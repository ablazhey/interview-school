Rails.application.routes.draw do
  resources :teachers do
    resources :teacher_subjects, shallow: true
  end

  resources :subjects
  resources :students
  resources :class_rooms
  resources :sections
  resources :schedules

  root to: 'subjects#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
