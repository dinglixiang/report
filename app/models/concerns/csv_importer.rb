require 'spreadsheet'
module CSVImporter
  COLUMNS = %w(name size unit company sell_date target_company sell_volume)

  def import(file, user)
    book = Spreadsheet.open file.path
    sheet1 = book.worksheet 0
    sheet1.each 1 do |row|
      begin
        record = row.to_a.compact.deep_delete_blank
        next if record.blank?
        report_hash = Hash[COLUMNS.map.with_index{|k, index| [k, record[index]]}]
        Report.create!(report_hash.merge(user_id: user.id))
      rescue Exception => e
        puts e.inspect
        next
      end
    end
  end
end
