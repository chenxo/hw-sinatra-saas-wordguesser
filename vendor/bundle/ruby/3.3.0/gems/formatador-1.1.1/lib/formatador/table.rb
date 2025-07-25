class Formatador
  def display_table(hashes, keys = nil, **options, &block)
    new_hashes = hashes.inject([]) do |accum,item|
      accum << :split unless accum.empty?
      accum << item
    end
    display_compact_table(new_hashes, keys, **options, &block)
  end

  def display_compact_table(hashes, keys = nil, **options, &block)
    headers = keys || []
    widths = {}

    # Calculate Widths
    if hashes.empty? && keys
      keys.each do |key|
        widths[key] = length(key)
      end
    else
      hashes.each do |hash|
        next unless hash.respond_to?(:keys)

        (headers + hash.keys).each do |key|
          if !keys
            headers << key
          end
          widths[key] = [length(key), widths[key] || 0, length(calculate_datum(key, hash)) || 0].max
        end
        headers = headers.uniq
      end
    end

    # Determine order of headers
    if block_given?
      headers = headers.sort(&block)
    elsif !keys
      headers = headers.sort {|x,y| x.to_s <=> y.to_s}
    end

    # Display separator row
    split = "+"
    if headers.empty?
      split << '--+'
    else
      headers.each do |header|
        widths[header] ||= length(header)
        split << ('-' * (widths[header] + 2)) << '+'
      end
    end
    display_line(split)

    # Display data row
    columns = []
    headers.each do |header|
      columns << "[bold]#{header}[/]#{' ' * (widths[header] - length(header))}"
    end
    display_line("| #{columns.join(' | ')} |")
    display_line(split)

    hashes.each do |hash|
      if hash.respond_to? :keys
        columns = headers.map do |header|
          datum = calculate_datum(header, hash)
          width = widths[header] - length(datum)
          width = width < 0 ? 0 : width

          datum.is_a?(Numeric) && options[:numeric_rjust] ? "#{' ' * width}#{datum}" : "#{datum}#{' ' * width}"
        end
        display_line("| #{columns.join(' | ')} |")
      else
        if hash == :split
          display_line(split)
        end
      end
      nil
    end
    display_line(split)
  end

  private

  def length(value)
    if Module.const_defined?(:Unicode) && Unicode.respond_to?(:width)
      Unicode.width(value.to_s.gsub(PARSE_REGEX, ''))
    else
      value.to_s.gsub(PARSE_REGEX, '').chars.reduce(0) { |sum, char| sum += char.bytesize > 1 ? 2 : 1 }
    end

  rescue NotImplementedError
    value.to_s.gsub(PARSE_REGEX, '').chars.reduce(0) { |sum, char| sum += char.bytesize > 1 ? 2 : 1 }
  end

  def calculate_datum(header, hash)
    if !hash.keys.include?(header) && (splits = header.to_s.split('.')).length > 1
      datum = nil
      splits.each do |split|
        d = (datum||hash)
        datum = d[split] || d[split.to_sym] || ''
      end
    else
      datum = hash.fetch(header, '')
    end
    datum
  end
end
