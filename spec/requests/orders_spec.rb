require 'rails_helper'

RSpec.describe "Orders", type: :request do
  describe "GET order_path" do
    it "renders the index view" do
      FactoryBot.create_list(:order, 10)
      get orders_path
      expect(response).to render_template(:index)
    end
  end
  describe "get order_path" do
    it "renders the :show template" do
      order = FactoryBot.create(:order)
      get customer_path(id: order.id)
      expect(response).to render_template(:show)
    end
    it "redirects to the index path if the customer id is invalid" do
      get order_path(id: 5000)
      expect(response).to redirect_to orders_path
    end
  end
  describe "get new_order_path" do
    it "renders the :new template" do
      get order_path(:new)
      expect(response).to render_template(:new)
    end
  end
  describe "get edit_order_path" do
    it "renders the :edit template" do
      order = FactoryBot.create(:order)
      get edit_order_path(id: order.id)
      expect(response).to render_template(:edit)
    end
  end
  describe "post order_path with valid data" do
    it "save a new order" do
      order_attributes = FactoryBot.attributes_for(:order)
      expect { post orders_path, params: {order: order_attributes} }.to change(Order, :count)
    end
  end
  describe "post order_path with invalid data" do
    it "does not save a new entry" do
      order_attributes = FactoryBot.attributes_for(:order)
      order_attributes.delete(:product_name)
      expect { post orders_path, params: {ordre:order_attributes} }.to_not change(Order, :count)
    end
  end
  describe "put order_path with valid data" do
    it "updates an entry and redirects to the show path for the customer" do
      order = FactoryBot.create(:order)
      put "/orders/#{order.id}", params: {order: {product_count: 50}}
      order.reload
      expect(order.product_count).to eq(50)
      expect(response).to redirect_to("/orders/#{order.id}")
    end
  end
  describe "put order_path with invalid data" do
    it "does not update the customer record or redirect" do
      order = FactoryBot.create(:order)
      put "/orders/#{order.id}", params: {order: {customer_id: 5001}}
      order.reload
      expect(order.customer_id).not_to eq(5001)
      expect(response).to render_template(:edit)
    end
  end
  describe "delete an order" do
    it "deletes an order" do
      order = FactoryBot.create(:order)
      count = Order.all.count
      delete order_path(order.id)
      expect(Order.all.count).to eq(count -1)
    end
  end
end
