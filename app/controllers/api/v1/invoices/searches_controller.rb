class Api::V1::Invoices::SearchesController < ApplicationController
  def show
    render json: "status".in?(column_param) ? (Invoice.find_by("lower(status) = ?", value_param)) : (Invoice.find_by(invoices_params))
  end

  def index
    render json: (Invoice.find_all(invoices_params))
  end

  def random
    render json: Invoice.order("RANDOM()").first
  end

  private

  def invoices_params
    params.permit(:id,
                  :customer_id,
                  :merchant_id,
                  :status,
                  :created_at,
                  :updated_at)
  end
end
