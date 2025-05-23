import os
from telegram import Update
from telegram.ext import Updater, MessageHandler, Filters
import vk_api

TG_TOKEN = os.getenv("7442107911:AAE1JoahhF4dcdWbM4JKpqiZ3sLXaDG8WaE")
VK_TOKEN = os.getenv("3e16f0f23e16f0f23e16f0f2053d24dab633e163e16f0f2562668114d0bfa9eda1f4d82")
VK_GROUP_ID = os.getenv("218615711")

def forward_to_vk(update: Update, context):
    # Проверяем, что это сообщение из канала
    if not update.channel_post:
        return

    # Получаем текст сообщения
    post_text = update.channel_post.text
    print(f"Новый пост: {post_text}")

    # Публикуем в ВК
    vk_session = vk_api.VkApi(token=VK_TOKEN)
    vk = vk_session.get_api()
    vk.wall.post(owner_id=VK_GROUP_ID, message=post_text)

# Запуск бота
updater = Updater(TG_TOKEN, use_context=True)
dispatcher = updater.dispatcher
dispatcher.add_handler(MessageHandler(Filters.update, forward_to_vk))
updater.start_polling()
updater.idle()
