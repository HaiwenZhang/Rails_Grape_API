class BijiAPI < Grape::API

  resource :user do

    params do
      requires :token, type: String
    end

    resource :notes do
      before do
        authenticate_user!
      end

      params do
        requires :title, type: String
        requires :content, type: String
      end

      post do
        status 200
        note = current_user.notes.new(title: params[:title], content: params[:content])
        if note.save
          {note_id: note.id}
        else
          {errors: note.errors.full_messages}
        end
      end

      get do
        present current_user.notes, with: Entities::Note
        # { notes: current_user.notes }
      end


      group ':id' do
        helpers do
          def set_note!
            @current_note = current_user.notes.where(id: params[:id]).first
            error!({errors: "note not found" }, 404) if @current_note.nil?
          end

          def current_note
            @current_note
          end
        end

        before do
          set_note!
        end

        params do
          requires :title, type: String
          requires :content, type: String
        end

        put do
          status 200
          if current_note.update(title: params[:title], content: params[:content])
            {success: true}
          else
            {errors: current_node.errors.full_messages}
          end
        end

        delete do
          if current_note.destroy!
            { success: true }
          else
            { errors: current_note.errors.full_messages }
          end
        end

        get do
          present current_note, with: Entities::Note
          # { title: current_note.title, content: current_note.content }
        end

      end
    end
  end
end