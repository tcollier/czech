require 'czech/dictionary'

describe Czech::Dictionary do
  describe ".initialize" do
    it "adds a word to the dict" do
      Czech::Hasher.stub(:generate => 'x')
      subject = Czech::Dictionary.new(['word'])
      subject.dict.should == { 'x' => ['word'] }
    end

    it "adds two words with the same hash to the dict" do
      Czech::Hasher.stub(:generate => 'x')
      subject = Czech::Dictionary.new(['word1', 'word2'])
      subject.dict.should == { 'x' => ['word1', 'word2'] }
    end

    it "adds two words with different hashes to the dict" do
      Czech::Hasher.stub(:generate).with('word1').and_return('x')
      Czech::Hasher.stub(:generate).with('word2').and_return('y')
      subject = Czech::Dictionary.new(['word1', 'word2'])
      subject.dict.should == { 'x' => ['word1'], 'y' => ['word2'] }
    end
  end

  describe "#suggest" do
    context "unit tests" do
      subject { Czech::Dictionary.new([]) }

      it "returns a word if it is in the dict" do
        Czech::Hasher.stub(:generate => 'x')
        subject.stub(:dict => { 'x' => ['word'] })
        subject.suggest('word').should == 'word'
      end

      it "returns a similaryly hashed word if the word is not in the dict" do
        Czech::Hasher.stub(:generate => 'x')
        subject.stub(:dict => { 'x' => ['word1'] })
        subject.suggest('word2').should == 'word1'
      end

      it "returns a properly cased word if is not in the first word in the dict" do
        Czech::Hasher.stub(:generate => 'x')
        subject.stub(:dict => { 'x' => ['word1', 'WORD2'] })
        subject.suggest('word2').should == 'WORD2'
      end

      it "returns 'NO SUGGESTION' if no word is hashed the same" do
        Czech::Hasher.stub(:generate => 'y')
        subject.stub(:dict => { 'x' => ['word1'] })
        subject.suggest('word2').should == 'NO SUGGESTION'
      end
    end

    context "words from challenge description" do
      subject { Czech::Dictionary.new(['sheep', 'people', 'inside', 'job', 'wake']) }

      it "suggests 'sheep' for 'sheeeeep'" do
        subject.suggest('sheeeeep').should == 'sheep'
      end

      it "suggests 'people' for 'peepple'" do
        subject.suggest('peepple').should == 'people'
      end

      it "has no suggestion for 'sheeple'" do
        subject.suggest('sheeple').should == 'NO SUGGESTION'
      end

      it "suggests 'inside' for 'inSIDE'" do
        subject.suggest('inSIDE').should == 'inside'
      end

      it "suggests 'job' for 'jjoobbb'" do
        subject.suggest('jjoobbb').should == 'job'
      end

      it "suggests 'wake' for 'weke'" do
        subject.suggest('weke').should == 'wake'
      end
    end

    context "other interesting cases" do
      it "suggests 'sheep' instead of 'shap' for 'sheeeeep'" do
        subject = Czech::Dictionary.new(['shap', 'sheep'])
        subject.suggest('sheeeeep').should == 'sheep'
      end
    end
  end
end