module Entities
  class Note < Grape::Entity
    root 'notes'
    expose :title
    expose :content
  end
end