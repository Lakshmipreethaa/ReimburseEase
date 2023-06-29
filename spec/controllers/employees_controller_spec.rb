require 'rails_helper'

RSpec.describe EmployeesController, type: :controller do
  let(:employee) do
    create(:employee)
  end

  describe 'get employees' do
    it 'renders the index template' do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe 'get employee' do
    employee = FactoryBot.create(:employee)
    it 'renders the show template' do
      get :show, params: { id: employee.id }
      expect(response).to render_template(:show)
    end
  end

  describe 'creates employee' do
    context 'with valid parameters' do
      department = FactoryBot.create(:department)
      designation = FactoryBot.create(:designation)
      it 'creates a new employee' do
        expect {
          post :create, params: { employee: { first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email: Faker::Internet.email, department_id: department.id, designation_id: designation.id  } }
        }.to change(Employee, :count).by(1)
        expect(flash[:success]).to eq('Employee has been created successfully')
        expect(response).to redirect_to(employees_path)
      end
    end

    context 'with invalid parameters' do
      department = FactoryBot.create(:department)
      designation = FactoryBot.create(:designation)
      it 'does not create a new employee' do
        expect {
          post :create, params: { employee: { last_name: Faker::Name.last_name, email: Faker::Internet.email, department_id: department.id, designation_id: designation.id } }
        }.not_to change(Employee, :count)
        expect(flash[:danger]).to include('First name can\'t be blank')
        expect(response).to redirect_to(employees_path)
      end
    end
  end

  describe 'PATCH #update' do
    context 'with valid parameters' do
      employee = FactoryBot.create(:employee)
      it 'updates the employee' do
        patch :update, params: { id: employee.id, employee: { first_name: 'Jane' } }
        employee.reload
        expect(employee.first_name).to eq('Jane')
        expect(flash[:success]).to eq('Employee has been updated successfully')
        expect(response.body).to eq({ success: true, flash_message: 'Employee has been updated successfully' }.to_json)
      end
    end

    context 'with invalid parameters' do
      it 'does not update the employee' do
        employee = FactoryBot.create(:employee)
        patch :update, params: { id: employee.id, employee: { first_name: nil } }
        employee.reload
        expect(flash[:danger]).to include('First name can\'t be blank')
        expect(response.body).to eq({ success: false, flash_message: 'Error First name can\'t be blank' }.to_json)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the employee' do
      employee = FactoryBot.create(:employee)
      expect {
        delete :destroy, params: { id: employee.id }
      }.to change(Employee, :count).by(-1)
      expect(flash[:success]).to eq('Employee has been deleted successfully')
      expect(response).to redirect_to(employees_path)
    end
  end
end
