require 'rails_helper'

describe StudentsController do
  describe 'GET #index' do
    before { get :index }

    it { expect(response).to render_template(:index) }
    it { expect(response).to have_http_status(200) }
  end

  describe 'GET #show' do
    context 'when it was found' do
      before { get :show, id: student.id }
      let(:student) { create(:student, name: 'Fagner', register_number: '123abc') }

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
      before { get :edit, id: student.id }
      let(:student) { create(:student, name: 'Fagner', register_number: '123abc') }

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
      let(:course) { create(:course, name: 'Course name', description: 'Course description') }
      let(:params) do
        { 
          student: 
            { 
              name: 'Fagner', 
              register_number: '123abc' 
            },
          classroom: {
            course_id: course.id
          }
        }
      end
      before do
        post :create, params
      end

      it { expect(response).to have_http_status(302) }
      it { expect(response).to redirect_to("/students/#{Student.first.id}") }
    end

    context 'when it occurs some error' do
      context 'when the course does not exist' do
        let(:params) do
          { 
            student: 
              { 
                name: 'Fagner', 
                register_number: '123abc' 
              },
            classroom: {
              course_id: 1
            }
          }
        end

        before do
          post :create, params
        end

        it { expect(response).to render_template(:new) }
        it { expect(response).to have_http_status(400) }
      end

      context 'when it missed some student param' do
        let(:course) { create(:course, name: 'Course name', description: 'Course description') }
        let(:params) do
          { 
            student: 
              { 
                name: 'Fagner'
              },
            classroom: {
              course_id: course.id
            }
          }
        end

        before do
          post :create, params
        end

        it { expect(response).to render_template(:new) }
        it { expect(response).to have_http_status(400) }        
      end
    end    
  end

  describe 'PUT #update' do
    context 'when it was successfully updated' do
      let(:student) { create(:student, name: 'Fagner', register_number: '123asd') }
      let(:course) { create(:course, name: 'Course name', description: 'Course description') }
      let(:updated_student) { Student.find(student.id) }
      let(:params) do
        { 
          id: student.id,
          student: 
            { 
              name: 'Fagner Updated', 
              register_number: '123abc' 
            },
          classroom: {
            course_id: course.id
          }
        }
      end
      before do
        put :update, params
      end

      it { expect(updated_student.name).to_not eq student.name }
      it { expect(response).to have_http_status(302) }
      it { expect(response).to redirect_to("/students/#{Student.first.id}") }
    end

    describe 'DELETE #destroy' do
      context 'when it was successfully updated' do
        let(:student) { create(:student, name: 'Fagner', register_number: '123asd') }
        let(:params) do
          { 
            id: student.id,
          }
        end
        before do
          delete :destroy, params
        end

        it { expect(response).to have_http_status(302) }
        it { expect(response).to redirect_to("/students") }
      end
    end
  end
end