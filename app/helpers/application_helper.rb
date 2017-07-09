# encoding: utf-8
# frozen_string_literal: true

# This is the ApplicationHelper module
module ApplicationHelper
  def application_title
    I18n.t('application_title')
  end

  def link_to_close_session
    link_to(
      glyph(:'log-out'),
      user_sessions_path,
      method: :delete,
      title: t('user_sessions.close_session'),
      data: {
        confirm: t('user_sessions.close_session_confirm')
      }
    )
  end

  def link_tpl(title, link)
    link_to(title, link, title: title)
  end

  def link_to_login
    link_tpl(t('user_sessions.login'), new_user_session_path)
  end

  def link_to_rating
    link_tpl(t('products.rating_page'), rating_path)
  end

  def link_to_products
    link_tpl(t('products.index_page'), root_path)
  end
end
