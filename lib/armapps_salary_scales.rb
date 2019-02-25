# This file provides methods to screen scrap data off the UC Davis HR salary scales website.
module ArmappsSalaryScales
  require 'mechanize'

  # Custom exceptions used in this module
  class ArmAppsSalaryScalesError < StandardError
  end
  class ArmAppsSalaryScalesNonOkHttpResponseError < ArmAppsSalaryScalesError
  end
  class ArmAppsSalaryScalesCannotInterpretPageError < ArmAppsSalaryScalesError
  end

  def self.fetch_title_by_code(code)
    return nil unless code

    code = code.to_i # sanitize

    agent = Mechanize.new
    page = agent.get("https://armapps.ucdavis.edu/salaryscale/DisplaySS.aspx?TitleCode=#{code}")

    raise ArmAppsSalaryScalesNonOkHttpResponseError if page.code.to_i != 200

    scrap_code = page.search('span#lblTitleCode').text.to_i

    raise ArmAppsSalaryScalesCannotInterpretPageError if scrap_code != code

    title_official_name = page.search('span#lblTitleName').text
    bargaining_unit = page.search('span#lblBargainingUnit').text

    return { official_name: title_official_name, code: code, unit: bargaining_unit }
  end
end
