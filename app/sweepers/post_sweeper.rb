class PostSweeper < ActionController::Caching::Sweeper
  observe Post

  def after_create(post)
    expire_cache_index(post)
  end

  def after_update(post)
    expire_cache_index(post)
    expire_cache_article(post.id)
  end

  def after_destroy(post)
    expire_cache_index(post)
    expire_cache_article(post.id)
  end

  private

  def expire_cache_index(post)
    expire_action(:controller => 'posts', :action => 'index')
  end

  def expire_cache_article(post_id)
    expire_action(:controller => 'posts', :action => 'show', :id => post_id)
  end

end