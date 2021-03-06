module EmailerHelper
  include ApplicationHelper
  include Umlaut::Helper


  # returns a plain text short citation
  def brief_citation(request, options = {})
    options[:include_labels] ||= false
    rv =""
    cite = request.referent.to_citation
    title = truncate(cite[:title].strip, :length => 70,  :separator => ' ')

    rv << (cite[:title_label].strip + ": ")if options[:include_labels] && cite[:title_label]
    rv << title
    rv << "\n"
    if cite[:author]
      rv << "#{t 'umlaut.citation.author_label'}:" if options[:include_labels]
      rv << cite[:author].strip
      rv << "\n"
    end
    if cite[:container_title]
      rv << (cite[:container_label].strip + ": ") if options[:include_labels] && cite[:container_label].present?
      rv << cite[:container_title].strip
      rv << "\n"
    end
    pub = []
    pub << date_format(cite[:date]) unless cite[:date].blank?
    pub << "#{t 'umlaut.citation.volume_abbr' }: " + cite[:volume].strip unless cite[:volume].blank?
    pub << "#{t 'umlaut.citation.issue_abbr'}: " + cite[:issue].strip unless cite[:issue].blank?
    pub << "#{t 'umlaut.citation.page_abbr'} " + cite[:page].strip unless cite[:page].blank?
    if pub.length > 0
      rv << "#{t 'umlaut.citation.published'}: " if options[:include_labels]
      rv << pub.join('  ')
    end
    return rv
  end

  def citation_identifiers(request, options = {})
    citation = request.referent.to_citation
    str = ""

    str << "#{t 'umlaut.citation.issn'}: #{citation[:issn]}\n" if citation[:issn]
    str << "#{t 'umlaut.citation.isbn'}: #{citation[:isbn]}\n" if citation[:isbn]
    citation[:identifiers].each do |identifier|
      str << "#{identifier}\n"
    end

    return str
  end
end