require 'spreadsheet'
module StockCSVImporter
  COLUMNS = %w(name size unit company stock_volume)

  def import(file, user)
    book = Spreadsheet.open file.path
    sheet1 = book.worksheet 0
    sheet1.each 1 do |row|
      begin
        record = row.to_a.compact.deep_delete_blank
        next if record.blank?
        stock_hash = Hash[COLUMNS.map.with_index{|k, index| [k, record[index]]}]
        Stock.create!(stock_hash.merge(user_id: user.id))
      rescue Exception => e
        puts e.inspect
        next
      end
    end
  end
end
