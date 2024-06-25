describe OgService, type: :service do

  describe '#getDocument' do
    let(:subject) { OgService.new(url) }

    context 'when url has og tags' do
      let(:url) { 'https://www.yankees.com' }

      it 'when valid url passed, returns values of tags' do
        expect(subject.getMetaTags).to eq({:title=>"Official New York Yankees Website | MLB.com",
                                           :ogtype=>"website",
                                           :url=>"https://www.yankees.com",
                                           :image=>"https://www.mlbstatic.com/team-logos/share/147.jpg",
                                           :description=>"The official website of the New York Yankees with the most up-to-date information on scores, schedule, stats, tickets, and team news."})
      end
    end

    context 'when url passed is invalid' do
      let(:url) { 'https://www.yankeesxx.com' }

      it 'returns nil' do
        expect(subject.getMetaTags).to be_nil
      end
    end
  end
end
