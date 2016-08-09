require 'spreadsheet'
module PurchaseCSVImporter
  COLUMNS = %w(upstream_client name size unit company purchase_date purchase_volume)

  def import(file)
    book = Spreadsheet.open file.path
    sheet1 = book.worksheet 0
    sheet1.each 1 do |row|
      begin
        record = row.to_a.compact.deep_delete_blank
        next if record.blank?
        purchase_hash = Hash[COLUMNS.map.with_index{|k, index| [k, record[index]]}]
        Purchase.create!(purchase_hash)
      rescue Exception => e
        puts e.inspect
        next
      end
    end
  end
end
