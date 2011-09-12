class CommentSweeper < ActionController::Caching::Sweeper
  observe Comment

  def after_create(comment)
    expire_cache_article(comment.post.id)
  end

  def after_destroy(comment)
    expire_cache_article(comment.post.id)
  end

  private

  def expire_cache_article(post_id)
    expire_action(:controller => 'posts', :action => 'show', :id => post_id)
  end

end