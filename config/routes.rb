Rails.application.routes.draw do
  mount NoteAPI, at: 'api'
end
