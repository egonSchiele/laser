require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Parsers do
  describe Parsers::AnnotationParser do
    it 'exists' do
      Parsers::AnnotationParser != nil
    end
  end
  describe Parsers::ClassParser do
    it 'exists' do
      Parsers::ClassParser != nil
    end
  end
end