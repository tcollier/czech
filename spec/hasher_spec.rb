require 'czech/hasher'

describe Czech::Hasher do
  describe ".generate" do
    subject { Czech::Hasher }

    it "changes a vowel to an 'a'" do
      subject.generate('e').should == 'a'
    end

    it "downcases a capital consonant" do
      subject.generate('F').should == 'f'
    end

    it "downcases a capital 'A'" do
      subject.generate('A').should == 'a'
    end

    it "downcases a capital 'E' and converts to 'a'" do
      subject.generate('e').should == 'a'
    end

    it "removes duplicate consonants" do
      subject.generate('ff').should == 'f'
    end

    it "removes duplicate vowels and converts to 'a'" do
      subject.generate('ee').should == 'a'
    end

    it "converts multiple different consective vowels to a single 'a'" do
      subject.generate('ie').should == 'a'
    end

    context "words from challenge description" do
      it "hashes 'sheeeeep' and 'sheep' the same" do
        subject.generate('sheeeeep').should == subject.generate('sheep')
      end

      it "hashes 'peepple' and 'people' the same" do
        subject.generate('peepple').should == subject.generate('people')
      end

      it "hashes 'inSIDE' and 'inside' the same" do
        subject.generate('inSIDE').should == subject.generate('inside')
      end

      it "hashes 'jjoobbb' and 'job' the same" do
        subject.generate('jjoobbb').should == subject.generate('job')
      end

      it "hashes 'weke' and 'wake' the same" do
        subject.generate('weke').should == subject.generate('wake')
      end
    end
  end
end