class LessonResourcesController < ApplicationController
  before_filter :authenticate_instructor!
end