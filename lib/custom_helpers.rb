# Returns all pages under a certain directory.
module CustomHelpers
  def sub_pages(dir)
    sitemap.resources.select do |resource|
      resource.path.start_with?(dir)
    end
  end
end
