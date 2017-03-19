class PurchasesController < ApplicationController
  before_action :search_purchases, only: [:index, :download]

  def index
    @purchases = @purchases.page(params[:page]).per(25)

    respond_to do |format|
      format.html
      format.js
    end
  end

  def new
  end

  def import
    Purchase.import(params[:file], current_user)
    redirect_to purchases_path
  end

  def truncate
    Purchase.where(user_id: current_user.id).delete_all
    redirect_to new_purchase_path
  end

  def download
    Spreadsheet.client_encoding = 'UTF-8'
    book = Spreadsheet::Workbook.new
    sheet1 = book.create_worksheet :name => 'Sheet1'
    format = Spreadsheet::Format.new color: :black, weight: :bold, size: 12
    sheet1.row(0).default_format = format

    sheet1.row(0).concat %w{上游客户 品名 规格 包装单位 厂家 日期 采购数量}
    @purchases.each_with_index do |purchase, index|
      sheet1.row(index+1).push(*[purchase.upstream_client, purchase.name, purchase.size, purchase.unit, purchase.company, purchase.purchase_date&.strftime('%F').to_s, format("%.3f", purchase.purchase_volume)].flatten)
    end
    filepath = Rails.root + "public/exports/#{Date.today}.xls"
    book.write filepath
    send_file filepath
  end

  private
    def search_purchases
      @purchases = params[:search].blank? ? current_user.purchases.none : current_user.purchases.where(search_params)

      conditions = []
      conditions << "purchase_date >= '#{params[:start_date].to_datetime.to_s(:db)}'" if params[:start_date].present?
      conditions << "purchase_date <= '#{params[:end_date].to_datetime.end_of_day.to_s(:db)}'" if params[:end_date].present?

      @purchases = @purchases.where(conditions.join(' AND ')) if conditions.present?
      @purchases = @purchases.order(:purchase_date)
    end
    def search_params
      base_params = params[:purchase].presence || params
      base_params.permit(name: [], size: [], unit:[], company: [], upstream_client: []).to_unsafe_h.deep_delete_blank
    end
end
