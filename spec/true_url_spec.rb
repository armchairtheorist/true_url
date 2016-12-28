require 'spec_helper'

def gc(unclean_url, options = {})
  TrueURL.new(unclean_url, options).canonical
end

describe TrueURL do
  describe 'YouTube' do
    it 'supports direct video links' do
      t = 'https://www.youtube.com/watch?v=RDocnbkHjhI'
      expect(gc('https://www.youtube.com/watch?v=RDocnbkHjhI')).to eq t
      expect(gc('https://www.youtube.com/watch?v=RDocnbkHjhI&feature=youtu.be&list=PLs4hTtftqnlAkiQNdWn6bbKUr-P1wuSm0')).to eq t
      expect(gc('https://youtu.be/RDocnbkHjhI?list=PLs4hTtftqnlAkiQNdWn6bbKUr-P1wuSm0')).to eq t
    end

    it 'supports embedded video links' do
      t = 'https://www.youtube.com/watch?v=RDocnbkHjhI'
      expect(gc('https://www.youtube.com/embed/RDocnbkHjhI?list=PLs4hTtftqnlAkiQNdWn6bbKUr-P1wuSm0')).to eq t
      expect(gc('https://www.youtube-nocookie.com/embed/RDocnbkHjhI?list=PLs4hTtftqnlAkiQNdWn6bbKUr-P1wuSm0&amp;controls=0&amp;showinfo=0')).to eq t
    end

    it 'supports direct playlist links' do
      t = 'https://www.youtube.com/playlist?list=PLVL8S3lUHf0RqD7TZ6hohWk8Sd3asaqnY'
      expect(gc('https://www.youtube.com/playlist?list=PLVL8S3lUHf0RqD7TZ6hohWk8Sd3asaqnY')).to eq t
      expect(gc('https://www.youtube.com/playlist?list=PLVL8S3lUHf0RqD7TZ6hohWk8Sd3asaqnY')).to eq t
    end

    it 'supports embedded playlist links' do
      t = 'https://www.youtube.com/playlist?list=PLVL8S3lUHf0RqD7TZ6hohWk8Sd3asaqnY'
      expect(gc('https://www.youtube.com/embed/videoseries?list=PLVL8S3lUHf0RqD7TZ6hohWk8Sd3asaqnY')).to eq t
      expect(gc('https://www.youtube-nocookie.com/embed/videoseries?list=PLVL8S3lUHf0RqD7TZ6hohWk8Sd3asaqnY')).to eq t
    end

    it 'supports direct channel links' do
      t = 'https://www.youtube.com/user/WatchMojo'
      expect(gc('https://www.youtube.com/channel/UCaWd5_7JhbQBe4dknZhsHJg')).to eq t
    end

    it 'supports retrieving embed links as attributes' do
      x = TrueURL.new('https://www.youtube-nocookie.com/embed/videoseries?list=PLVL8S3lUHf0RqD7TZ6hohWk8Sd3asaqnY')
      expect(x.attributes[:embed_url]).to eq 'https://www.youtube.com/embed/videoseries?list=PLVL8S3lUHf0RqD7TZ6hohWk8Sd3asaqnY'

      x = TrueURL.new('https://www.youtube.com/embed/RDocnbkHjhI?list=PLs4hTtftqnlAkiQNdWn6bbKUr-P1wuSm0&amp;controls=0&amp;showinfo=0')
      expect(x.attributes[:embed_url_private]).to eq 'https://www.youtube-nocookie.com/embed/RDocnbkHjhI'
    end
  end

  describe "DailyMotion" do
    it "supports direct video links" do
      t = "https://www.dailymotion.com/video/x2k01a9"
      expect(gc("http://dai.ly/x2k01a9")).to eq t
      expect(gc("http://www.dailymotion.com/video/x2k01a9_battlefield-what-s-it-like-to-be-in-a-real-life-video-game_fun")).to eq t
    end

    it "supports embedded video links" do
      t = "https://www.dailymotion.com/video/x2k01a9"
      expect(gc("http://www.dailymotion.com/embed/video/x2k01a9?autoPlay=1&start=40")).to eq t
    end

    it "supports direct playlist links" do
      t = "https://www.dailymotion.com/playlist/x1ybux"
      expect(gc("https://www.dailymotion.com/playlist/x1ybux/1#video=xlbw3e")).to eq t
      expect(gc("https://www.dailymotion.com/playlist/x1ybux")).to eq t
      expect(gc("http://www.dailymotion.com/playlist/x1ybux_ODNandfinally_amazing-world-records/1#video=xlbw3e")).to eq t
    end

    it 'supports retrieving embed links as attributes' do
      x = TrueURL.new('http://www.dailymotion.com/video/x2k01a9_battlefield-what-s-it-like-to-be-in-a-real-life-video-game_fun')
      expect(x.attributes[:embed_url]).to eq 'https://www.dailymotion.com/embed/video/x2k01a9'
    end

    it 'supports force HTTPS'do
      t = "https://www.dailymotion.com/ODNandfinally"
      expect(gc("http://www.dailymotion.com/ODNandfinally")).to eq t
    end
  end

  describe "Vimeo" do
    it "supports direct video links" do
      t = "https://vimeo.com/122258599"
      expect(gc("https://vimeo.com/channels/staffpicks/122258599")).to eq t
      expect(gc("http://vimeo.com/122258599")).to eq t
    end

    it "supports embedded video links" do
      t = "https://vimeo.com/122258599"
      expect(gc("https://player.vimeo.com/video/122258599?loop=1&color=c9ff23&title=0")).to eq t
    end

    it "supports Vimeo's relative canonical links" do
      t = "https://vimeo.com/channels/staffpicks"
      expect(gc("http://vimeo.com/channels/staffpicks?some=silly&params=here")).to eq t
    end

    it 'supports retrieving embed links as attributes' do
      x = TrueURL.new('https://vimeo.com/channels/staffpicks/122258599')
      expect(x.attributes[:embed_url]).to eq 'https://player.vimeo.com/video/122258599'
    end

    it 'supports force HTTPS' do
      t = "https://vimeo.com/user3190002"
      expect(gc("http://vimeo.com/user3190002")).to eq t
    end
  end

  describe "Nico Nico Douga" do
    it "should work with direct and embedded video links" do
      t = "http://www.nicovideo.jp/watch/sm25956031"
      expect(gc("http://ext.nicovideo.jp/thumb_watch/sm25956031?w=490&h=307")).to eq t
      expect(gc("http://embed.nicovideo.jp/watch/sm25956031/script?w=490&h=307&redirect=1")).to eq t
      expect(gc("http://embed.nicovideo.jp/watch/sm25956031?oldScript=1")).to eq t
    end

    it 'supports retrieving embed links as attributes' do
      x = TrueURL.new('http://ext.nicovideo.jp/thumb_watch/sm25956031?w=490&h=307')
      expect(x.attributes[:embed_url]).to eq 'http://embed.nicovideo.jp/watch/sm25956031'
    end
  end

  #    it "should work with Vine" do
  # 	t = "https://vine.co/v/Ol2jhmDTn6D"
  #        expect(gc("https://vine.co/v/Ol2jhmDTn6D/embed/simple?audio=yes")).to eq t
  # end

  #    it "should work with Twitter" do
  # 	t = "https://twitter.com/gangsta_project/status/578483098284748801"
  #        expect(gc("https://twitter.com/GANGSTA_Project/status/578483098284748801/photo/1")).to eq t
  #        expect(gc("https://twitter.com/GANGSTA_Project/status/578483098284748801/")).to eq t
  #        expect(gc("https://twitter.com/#!/GANGSTA_Project/status/578483098284748801/")).to eq t
  # end

  # describe "Facebook" do
  #     it "supports Facebook" do
  #         t = "https://www.facebook.com/cds.sg"
  #         expect(gc("http://www.facebook.com/cds.sg?fref=photo")).to eq t
  #     end
  # end





  # describe 'URL Shorteners' do
  #   it 'should work with t.co' do
  #     t = 'http://www.prdaily.com/Main/Articles/3_essential_skills_for_todays_PR_pro__18404.aspx'
  #     expect(gc('http://t.co/fvaGuRa5Za')).to eq t
  #     expect(gc('https://t.co/fvaGuRa5Za')).to eq t
  #   end

  #   it 'should work with fb.me' do
  #     t = 'https://www.facebook.com/aksuperdance/posts/1388968827814771'
  #     expect(gc('http://fb.me/8qm5kW89k')).to eq t
  #   end

  #   it 'should work with ift.tt' do
  #     t = 'http://tedxtaipei.com/articles/the_best_kindergarten_you_have_ever_seen/'
  #     expect(gc('http://ift.tt/2iCbPy8')).to eq t
  #   end

  #   it 'should work with compounded URL shorteners' do
  #     t = 'https://www.youtube.com/watch?v=jLhjsPjR-xk'
  #     expect(gc('https://t.co/g4NYtZE3lW')).to eq t # http://bit.ly/2iCKic3 --> http://youtu.be/jLhjsPjR-xk?list=PLVL8S3lUHf0RqD7TZ6hohWk8Sd3asaqnY
  #   end
  # end

  # describe 'WordPress' do
  #   it 'supports missing trailing slashes' do
  #     t = 'http://wowjapan.asia/2015/04/anime-gargantia-on-the-verdurous-planet-2nd-season-cancelled/'
  #     expect(gc('http://wowjapan.asia/2015/04/anime-gargantia-on-the-verdurous-planet-2nd-season-cancelled')).to eq t
  #   end
  # end

  # describe 'Blogger' do
  #   it 'supports missing localized Blogger domains' do
  #     t = 'http://thevikiblog.blogspot.com/2015/12/soompi-ios-android.html'
  #     expect(gc('http://thevikiblog.blogspot.sg/2015/12/soompi-ios-android.html')).to eq t
  #   end
  # end

  # describe 'Other Scenarios' do
  #   it 'supports missing schemes' do
  #     t = 'http://wowjapan.asia/2015/04/anime-gargantia-on-the-verdurous-planet-2nd-season-cancelled/'
  #     expect(gc('//wowjapan.asia/2015/04/anime-gargantia-on-the-verdurous-planet-2nd-season-cancelled/')).to eq t
  #   end

  #   it 'supports scheme override' do
  #     t = 'https://wowjapan.asia/2015/04/anime-gargantia-on-the-verdurous-planet-2nd-season-cancelled/'
  #     expect(gc('//wowjapan.asia/2015/04/anime-gargantia-on-the-verdurous-planet-2nd-season-cancelled/', scheme_override: 'https')).to eq t
  #   end

  #   it 'supports CDJapan' do
  #     t = 'http://www.cdjapan.co.jp/product/MDR-1012'
  #     expect(gc('http://www.cdjapan.co.jp/aff/click.cgi/e86NDzbdSLQ/4323/A323439/detailview.html?KEY=MDR-1012')).to eq t
  #   end

  #   it 'supports MyAnimeList' do
  #     t = 'https://myanimelist.net/forum/?topicid=1371295'
  #     expect(gc('https://myanimelist.net/forum?topicid=1371295&goto=newpost')).to eq t
  #   end

  #   it 'supports unnecessary self-expanding sites' do
  #     t = 'https://sekainoowari.jp/'
  #     expect(gc('http://sekainoowari.jp')).to eq t
  #   end

  #   it 'supports URLs with escapable characters' do
  #     t = 'http://goboiano.com/news/2568-attack-on-titan%2527s-first-live-action-trailer-finally-launches'
  #     expect(gc("http://media.goboiano.com/news/2568-attack-on-titan's-first-live-action-trailer-finally-launches")).to eq t

  #     t = 'http://randomc.net/image/Kekkai%20Sensen/Kekkai%20Sensen%20-%2001%20-%20Large%2001.jpg'
  #     expect(gc('http://randomc.net/image/Kekkai Sensen/Kekkai Sensen - 01 - Large 01.jpg')).to eq t
  #   end
  # end
end
