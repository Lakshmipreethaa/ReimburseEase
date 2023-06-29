require 'rails_helper'

RSpec.describe DepartmentsController, type: :controller do
  let(:department) do
    create(:department)
  end

  describe 'get departments' do
    it 'renders the index template' do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe 'create departments' do
    context 'with parameters that are valid' do
      it 'creates departments' do
        expect {
          post :create, params: { department: { name: 'New Department' } }
        }.to change(Department, :count).by(1)
        expect(flash[:success]).to eq('Department created successfully')
      end
    end

    context 'with parameters that are invalid' do
      it 'does not create a new department' do
        expect {
          post :create, params: { department: { name: nil } }
        }.not_to change(Department, :count)
        expect(flash[:danger]).to include('Name can\'t be blank')
      end
    end
  end

  describe 'Update department' do
    context 'with valid parameters' do
      department = FactoryBot.create(:department)
      it 'updates the department' do
        patch :update, params: { id: department.id, department: { name: 'New Department' } }
        department.reload
        expect(department.name).to eq('New Department')
        expect(flash[:success]).to eq('Department updated successfully')
      end
    end

    context 'with invalid parameters' do
      department = FactoryBot.create(:department)
      it 'does not update the department' do
        patch :update, params: { id: department.id, department: { name: nil } }
        department.reload
        expect(flash[:danger]).to include('Name can\'t be blank')
        expect(response.body).to eq({ success: false, flash_message: 'Error. Name can\'t be blank' }.to_json)
      end
    end
  end

  describe 'Deletes departments' do
    context 'with no employees associated with it' do
      department = FactoryBot.create(:department)
      it 'destroys the department' do
        expect {
          delete :destroy, params: { id: department.id }
        }.to change(Department, :count).by(-1)
        expect(flash[:success]).to eq('Department deleted successfully')
        expect(response).to redirect_to(departments_path)
      end
    end
  end

  context 'with associated employees' do
    department = FactoryBot.create(:department)
    employee = FactoryBot.create(:employee, department: department)

    it 'does not destroy the department' do
      expect {
        delete :destroy, params: { id: department.id }
      }.not_to change(Department, :count)
      expect(flash[:danger]).to include("Cannot delete Department. There are #{department.employees.count} employees associated with it.")
      expect(response).to redirect_to(departments_path)
    end
  end
end
