require 'rails_helper'

describe CoursesController do
  describe 'GET #index' do
    before { get :index }

    it { expect(response).to render_template(:index) }
    it { expect(response).to have_http_status(200) }
  end

  describe 'GET #show' do
    context 'when it was found' do
      before { get :show, id: course.id }
      let(:course) { create(:course, name: 'Course name', description: 'Course description') }

      it { expect(response).to render_template(:show) }
      it { expect(response).to have_http_status(200) }
    end

    context 'when it was not found' do
      before { get :show, id: 1 }

      it { expect(response).to have_http_status(404) }
    end
  end

  describe 'GET #edit' do
    context 'when it was found' do
      before { get :edit, id: course.id }
      let(:course) { create(:course, name: 'Course name', description: 'Course description') }

      it { expect(response).to render_template(:edit) }
      it { expect(response).to have_http_status(200) }
    end

    context 'when it was not found' do
      before { get :show, id: 1 }

      it { expect(response).to have_http_status(404) }
    end
  end

  describe 'POST #create' do
    context 'when it was successfully created' do
      let(:params) do
        { 
          course: 
            { 
              name: 'Course name', 
              description: 'Course description' 
            }
        }
      end
      before do
        post :create, params
      end

      it { expect(response).to have_http_status(302) }
      it { expect(response).to redirect_to("/courses/#{Course.first.id}") }
    end

    context 'when it occurs some error' do
      context 'when it missed some course param' do
        let(:course) { create(:course, name: 'Course name', description: 'Course description') }
        let(:params) do
          { 
            course: 
              { 
                name: 'Course name'
              }
          }
        end

        before do
          post :create, params
        end

        it { expect(response).to render_template(:new) }
        it { expect(response).to have_http_status(422) }        
      end
    end    
  end

  describe 'PUT #update' do
    context 'when it was successfully updated' do
      let(:course) { create(:course, name: 'Fagner', description: '123asd') }
      let(:updated_course) { Course.find(course.id) }
      let(:params) do
        { 
          id: course.id,
          course: 
            { 
              name: 'Course Updated', 
              description: 'Course description' 
            },
          classroom: {
            course_id: course.id
          }
        }
      end
      before do
        put :update, params
      end

      it { expect(updated_course.name).to_not eq course.name }
      it { expect(response).to have_http_status(302) }
      it { expect(response).to redirect_to("/courses/#{Course.first.id}") }
    end

    describe 'DELETE #destroy' do
      context 'when it was successfully updated' do
        let(:course) { create(:course, name: 'Course name', description: '123asd') }
        let(:params) do
          { 
            id: course.id,
          }
        end
        before do
          delete :destroy, params
        end

        it { expect(response).to have_http_status(302) }
        it { expect(response).to redirect_to("/courses") }
      end
    end
  end
end