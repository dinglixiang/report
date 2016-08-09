class Hash
  def delete_blank
    delete_if{|k, v| v.empty? or v.instance_of?(Hash) && v.delete_blank.empty?}
  end

  def deep_delete_blank
    deep_dup.deep_delete_blank!
  end

  def deep_delete_blank!
    delete_if { |_, value|
      if value.respond_to?(:blank?) && !(FalseClass === value)
        value.blank? || (Hash === value || Array === value) && value.deep_delete_blank!.blank?
      end
    }
  end
end

class Array
  # 多重数组去掉空值
  # **保留false**
  def deep_delete_blank
    deep_dup.deep_delete_blank!
  end

  def deep_delete_blank!
    delete_if { |value|
      if value.respond_to?(:blank?) && !(FalseClass === value)
        value.blank? || (Hash === value || Array === value) && value.deep_delete_blank!.blank?
      end
    }
  end
end
