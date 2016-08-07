require 'spreadsheet'
module CSVImporter
  COLUMNS = %w(name size unit company sell_date target_company sell_volume)

  def import(file)
    book = Spreadsheet.open file.path
    sheet1 = book.worksheet 0
    sheet1.each 1 do |row|
      begin
        record = row.to_a.compact.reject(&:blank?)
        report_hash = Hash[COLUMNS.map.with_index{|k, index| [k, record[index]]}]
        Report.create!(report_hash)
      rescue e
        puts e.inspect
        next
      end
    end
  end
end
