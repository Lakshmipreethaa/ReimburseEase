require 'rails_helper'

RSpec.describe DesignationsController, type: :controller do
  let(:designation) do
    create(:designation)
  end

  describe 'get designation' do
    it 'renders the index template' do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe 'create designation' do
    context 'with parameters that are valid' do
      it 'creates designation' do
        expect {
          post :create, params: { designation: { name: 'New designation' } }
        }.to change(Designation, :count).by(1)
        expect(flash[:success]).to eq('Designation created successfully')
      end
    end

    context 'with parameters that are invalid' do
      it 'does not create a new designation' do
        expect {
          post :create, params: { designation: { name: nil } }
        }.not_to change(Designation, :count)
        expect(flash[:danger]).to include('Name can\'t be blank')
      end
    end
  end

  describe 'Update designation' do
    context 'with valid parameters' do
        designation = FactoryBot.create(:designation)
      it 'updates the designation' do
        patch :update, params: { id: designation.id, designation: { name: 'New designation' } }
        designation.reload
        expect(designation.name).to eq('New designation')
        expect(flash[:success]).to eq('Designation updated successfully')
      end
    end

    context 'with invalid parameters' do
      designation = FactoryBot.create(:designation)
      it 'does not update the designation' do
        patch :update, params: { id: designation.id, designation: { name: nil } }
        designation.reload
        expect(flash[:danger]).to include('Name can\'t be blank')
        expect(response.body).to eq({ success: false, flash_message: 'Error. Name can\'t be blank' }.to_json)
      end
    end
  end

  describe 'Deletes designation' do
    context 'with no employees associated with it' do
        designation = FactoryBot.create(:designation)
      it 'destroys the designation' do
        expect {
          delete :destroy, params: { id: designation.id }
        }.to change(Designation, :count).by(-1)
        expect(flash[:success]).to eq('Designation deleted successfully')
        expect(response).to redirect_to(designations_path)
      end
    end

    context 'with associated employees' do
      designation = FactoryBot.create(:designation)
      employee = FactoryBot.create(:employee, designation: designation)
  
      it 'does not destroy the designation' do
        expect {
          delete :destroy, params: { id: designation.id }
        }.not_to change(Designation, :count)
        expect(flash[:danger]).to include("Cannot delete Designation. There are #{designation.employees.count} employees associated with it.")
        expect(response).to redirect_to(designations_path)
      end
    end
  end
end
