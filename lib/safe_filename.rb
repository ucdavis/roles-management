# Controller-level helper to generate safe Unix filenames
module SafeFilename
  # Taken from http://stackoverflow.com/questions/3932704/where-should-i-put-controller-helper-methods
  def unix_filename(filename)
    filename.gsub(/[^\w\s_-]+/, '')
            .gsub(/(^|\b\s)\s+($|\s?\b)/, '\\1\\2')
            .gsub(/\s+/, '_')
  end
end
