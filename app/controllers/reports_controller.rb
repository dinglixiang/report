class ReportsController < ApplicationController
  before_action :search_reports, only: [:index, :download]

  def index
    @reports = @reports.page(params[:page]).per(25)

    respond_to do |format|
      format.html
      format.js
    end
  end

  def import
    Report.import(params[:file])
    redirect_to reports_path
  end

  def truncate
    ActiveRecord::Base.connection.execute("TRUNCATE TABLE reports")
    redirect_to new_report_path
  end

  def signout
    request_http_basic_authentication
  end

  def download
    Spreadsheet.client_encoding = 'UTF-8'
    book = Spreadsheet::Workbook.new
    sheet1 = book.create_worksheet :name => 'Sheet1'
    format = Spreadsheet::Format.new color: :black, weight: :bold, size: 12
    sheet1.row(0).default_format = format

    sheet1.row(0).concat %w{品名 规格 包装单位 厂家 日期 往来单位名称 出库数量}
    @reports.each_with_index do |report, index|
      sheet1.row(index+1).push(*[report.name, report.size, report.unit, report.company, report.sell_date&.strftime('%F').to_s, report.target_company, format("%.3f", report.sell_volume)].flatten)
    end
    filepath = Rails.root + "public/exports/#{Date.today}.xls"
    book.write filepath
    send_file filepath
  end

  private
    def search_reports
      @reports = params[:search].blank? ? Report.none : Report.where(search_params)

      conditions = []
      conditions << "sell_date >= '#{params[:start_date].to_datetime.to_s(:db)}'" if params[:start_date].present?
      conditions << "sell_date <= '#{params[:end_date].to_datetime.end_of_day.to_s(:db)}'" if params[:end_date].present?

      @reports = @reports.where(conditions.join(' AND ')) if conditions.present?
      @reports = @reports.order(:sell_date)
    end
    def search_params
      base_params = params[:report].presence || params
      base_params.permit(name: [], size: [], unit:[], company: [], target_company: []).to_unsafe_h.deep_delete_blank
    end
end
