Palindrome::Application.routes.draw do

  root to: "home#splash"

  scope path: "/lesson-plans", controller: "lesson_plans",
                              constraints: { lesson_plan_id: /[0-9]+/ } do
    get "/" => :index, as: :lesson_plans
    get "/new" => :new, as: :new_lesson_plan
    post "/" => :create, as: :create_lesson_plan
    get "/:lesson_plan_id" => :show, as: :lesson_plan
    get "/:lesson_plan_id/edit" => :edit, as: :edit_lesson_plan
    put "/:lesson_plan_id" => :update, as: :update_lesson_plan
    delete "/:lesson_plan_id" => :destroy, as: :destroy_lesson_plan
  end

  scope path: "/lesson-plans/:lesson_plan_id/learning-resources", controller: "learning_resources",
                                                                 constraints: { lesson_plan_id: /[0-9]+/ } do
    post "/" => :index, as: :learning_resources
  end

  scope path: "/lesson-plans/:lesson_plan_id/learning-resources/:learning_resource_id/lesson-resources", controller: "lesson_resources",
                                                                                                        constraints: { lesson_plan_id: /[0-9]+/,
                                                                                                                 learning_resource_id: /[0-9]+/ } do
    get "/" => :index, as: :lesson_resources
  end
end
