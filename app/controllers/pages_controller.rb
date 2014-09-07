class PagesController < ApplicationController
  before_filter :authenticate_user!, :except => [:landing]
end
