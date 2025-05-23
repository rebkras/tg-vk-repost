import os
from telegram import Update
from telegram.ext import Updater, MessageHandler, Filters
import vk_api



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
