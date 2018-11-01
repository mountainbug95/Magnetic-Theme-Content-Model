module LinkFilter
  def link(input)
    relative_path = input.strip

    return relative_path if relative_path.start_with?("#")

    site = @context.registers[:site]

    site.each_site_file do |item|
      return item.url if item.relative_path == relative_path
      # This takes care of the case for static files that have a leading /
      return item.url if item.relative_path == "/#{relative_path}"
    end

    raise ArgumentError, <<~MSG
      Could not find document '#{relative_path}' in 'link' filter.

      Make sure the document exists and the path is correct.
    MSG
  end
end

Liquid::Template.register_filter(LinkFilter)
