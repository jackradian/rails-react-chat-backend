Rails.application.config.session_store :cache_store, key: "_chat_api_#{Rails.env}_session", expire_after: 1.days
