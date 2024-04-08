# main.py 8000 port
import asyncio
from typing import AsyncIterable, Any
from decouple import config
from fastapi import FastAPI
from fastapi.responses import HTMLResponse, StreamingResponse
from fastui import prebuilt_html, FastUI, AnyComponent
from fastui import components as c
from fastui.components.display import DisplayLookup, DisplayMode
from fastui.events import PageEvent, GoToEvent
from openai import OpenAI
import os
from dotenv import load_dotenv
from pydantic import BaseModel, Field  
load_dotenv('.env')

TOGETHER_API_KEY = os.getenv("TOGETHER_API_KEY")
client = OpenAI(
  api_key=TOGETHER_API_KEY,
  base_url='https://api.together.xyz/v1',
)

# Create the app object
app = FastAPI()

# Message history
app.message_history = []

class MessageHistoryModel(BaseModel):
    message: str = Field(title='Message')

# Chat form
class ChatForm(BaseModel):
    chat: str = Field(title=' ', max_length=1000)

@app.get('/api/', response_model=FastUI, response_model_exclude_none=True)
def api_index(chat: str | None = None, reset: bool = False) -> list[AnyComponent]:
    if reset:
        app.message_history = []
    return [
        c.PageTitle(text='FastUI Chatbot'),
        c.Page(
            components=[
                # Header
                c.Heading(text='Interview Chatbot'),
                # c.Paragraph(text='This is a simple chatbot built with FastUI and MistralAI.'),
                # Chat history
                c.Table(
                    data=app.message_history,
                    data_model=MessageHistoryModel,
                    columns=[DisplayLookup(field='message', mode=DisplayMode.markdown, table_width_percent=100)],
                    no_data_message='No messages yet.',
                ),
                # Chat form
                c.ModelForm(model=ChatForm, submit_url=".", method='GOTO'),
                # Reset chat
                c.Link(
                    components=[c.Text(text='Reset Chat')],
                    on_click=GoToEvent(url='/?reset=true'),
                ),
                # Chatbot response
                c.Div(
                    components=[
                        c.ServerLoad(
                            path=f"/sse/{chat}",
                            sse=True,
                            load_trigger=PageEvent(name='load'),
                            components=[],
                        )
                    ],
                    class_name='my-2 p-2 border rounded'),
            ],
        ),
        # Footer
        c.Footer(
            extra_text='Made with FastUI',
            links=[]
        )
    ]

@app.get('/api/sse/{prompt}')
async def sse_ai_response(prompt: str) -> StreamingResponse:
    # Check if prompt is empty
    if prompt is None or prompt == '' or prompt == 'None':
        return StreamingResponse(empty_response(), media_type='text/event-stream')
    return StreamingResponse(ai_response_generator(prompt), media_type='text/event-stream')


async def empty_response() -> AsyncIterable[str]:
    # Send the message
    m = FastUI(root=[c.Markdown(text='')])
    msg = f'data: {m.model_dump_json(by_alias=True, exclude_none=True)}\n\n'
    yield msg
    # Avoid the browser reconnecting
    while True:
        yield msg
        await asyncio.sleep(10)


# OpenAI response generator
async def ai_response_generator(prompt: str) -> AsyncIterable[str]:
    # Get response from OpenAI
    response = chat_qa(prompt)
    # Stream the response
    user_input = f"User: {prompt}\n\n"
    chatbot_response = f"Chatbot: {response}"
    
    user_input_component = c.Markdown(text=user_input)
    chatbot_response_component = c.Markdown(text=chatbot_response)
    
    # Send user input
    yield f'data: {FastUI(root=[user_input_component]).model_dump_json(by_alias=True, exclude_none=True)}\n\n'
    await asyncio.sleep(1)
    
    # Send chatbot response
    yield f'data: {FastUI(root=[chatbot_response_component]).model_dump_json(by_alias=True, exclude_none=True)}\n\n'
    
    # Append the message to the history
    message_user = MessageHistoryModel(message=user_input)
    message_chatbot = MessageHistoryModel(message=chatbot_response)
    app.message_history.append(message_user)
    app.message_history.append(message_chatbot)
    
    # Avoid the browser reconnecting
    while True:
        await asyncio.sleep(10)

def chat_qa(question : str) -> str:
    chat_completion = client.chat.completions.create(
        messages=[
            {
                "role": "system",
                "content": "You are an expert interview bot.",
            },
            {
                "role": "user",
                "content": f"{question}",
            }
        ],
        model="mistralai/Mixtral-8x7B-Instruct-v0.1"
    )
    return (chat_completion.choices[0].message.content)

@app.get('/{path:path}')
async def html_landing() -> HTMLResponse:
    """Simple HTML page which serves the React app, comes last as it matches all paths."""
    return HTMLResponse(prebuilt_html(title='FastUI Demo'))
