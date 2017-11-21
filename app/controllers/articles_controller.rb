require 'kramdown'

class ArticlesController < ApplicationController
  before_action :article_params, only: [:create, :update]

  def index
    @articles = Article.all
  end

  def create
    @article = Article.new(article_params)
    @article.save
    redirect_to article_path(@article)
  end

  def new
    @article = Article.new
  end

  def edit
    @article = Article.find(params[:id])
  end

  def show
    set_article
  end

  def update
    set_article
    @article.update(article_params)
    redirect_to article_path(@article)
  end

  def destroy
    set_article
    @article.destroy
    redirect_to articles_path
  end

  private

  def set_article
    @article = Article.find(params[:id])
    @article.title = Kramdown::Document.new(@article.title).to_html
    @article.content = Kramdown::Document.new(@article.content).to_html
  end

  def article_params
    params.require(:article).permit(:title, :content)
  end
end
