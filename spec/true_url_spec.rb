require 'spec_helper'

def gc (unclean_url)
    TrueURL.new(unclean_url).canonical
end

describe TrueURL do
    it "should work with YouTube" do
		t = "https://www.youtube.com/watch?v=RDocnbkHjhI"
        expect(gc("https://youtu.be/RDocnbkHjhI?list=PLs4hTtftqnlAkiQNdWn6bbKUr-P1wuSm0")).to eq t
        expect(gc("https://www.youtube.com/embed/RDocnbkHjhI?list=PLs4hTtftqnlAkiQNdWn6bbKUr-P1wuSm0")).to eq t
        expect(gc("https://www.youtube-nocookie.com/embed/RDocnbkHjhI?list=PLs4hTtftqnlAkiQNdWn6bbKUr-P1wuSm0&amp;controls=0&amp;showinfo=0")).to eq t
	end

    it "should work with DailyMotion" do
		t = "https://www.dailymotion.com/video/x2k01a9"
        expect(gc("http://dai.ly/x2k01a9")).to eq t
        expect(gc("http://www.dailymotion.com/video/x2k01a9_battlefield-what-s-it-like-to-be-in-a-real-life-video-game_fun")).to eq t
        expect(gc("http://www.dailymotion.com/embed/video/x2k01a9?autoPlay=1&start=40")).to eq t
	end

    it "should work with Vimeo" do
		t = "https://vimeo.com/122258599"
        expect(gc("https://vimeo.com/channels/staffpicks/122258599")).to eq t
        expect(gc("https://player.vimeo.com/video/122258599?loop=1&color=c9ff23&title=0")).to eq t
	end

    it "should work with Nico Nicno Douga" do
		t = "https://www.nicovideo.jp/watch/sm25956031"
        expect(gc("http://rd.nicovideo.jp/cc/ustop/translator?cc_id=sm25956031")).to eq t
        expect(gc("http://ext.nicovideo.jp/thumb_watch/sm25956031?w=490&h=307")).to eq t
	end
	
    it "should work with Vine" do
		t = "https://vine.co/v/Ol2jhmDTn6D"
        expect(gc("https://vine.co/v/Ol2jhmDTn6D/embed/simple?audio=yes")).to eq t
	end

    it "should work with Twitter" do
		t = "https://twitter.com/gangsta_project/status/578483098284748801"
        expect(gc("https://twitter.com/GANGSTA_Project/status/578483098284748801/photo/1")).to eq t
        expect(gc("https://twitter.com/GANGSTA_Project/status/578483098284748801/")).to eq t
        expect(gc("https://twitter.com/#!/GANGSTA_Project/status/578483098284748801/")).to eq t
	end

    it "should work with Twitter URL shortener" do
		t = "https://www.prdaily.com/Main/Articles/3_essential_skills_for_todays_PR_pro__18404.aspx"
        expect(gc("http://t.co/fvaGuRa5Za")).to eq t
	end

    it "should work with other scenarios" do
        t = "https://www.afachan.asia/2015/04/anime-gargantia-on-the-verdurous-planet-2nd-season-cancelled"
        expect(gc("www.afachan.asia/2015/04/anime-gargantia-on-the-verdurous-planet-2nd-season-cancelled")).to eq t

        t = "https://thevikiblog.blogspot.com/2015/12/soompi-ios-android.html"
        expect(gc("http://thevikiblog.blogspot.sg/2015/12/soompi-ios-android.html")).to eq t

        t = "https://randomc.net/image/Kekkai%20Sensen/Kekkai%20Sensen%20-%2001%20-%20Large%2001.jpg"
        expect(gc("http://randomc.net/image/Kekkai Sensen/Kekkai Sensen - 01 - Large 01.jpg")).to eq t

        t = "https://goboiano.com/news/2568-attack-on-titan%2527s-first-live-action-trailer-finally-launches"
        expect(gc("http://media.goboiano.com/news/2568-attack-on-titan's-first-live-action-trailer-finally-launches")).to eq t

        t = "https://www.facebook.com/cds.sg"
        expect(gc("https://www.facebook.com/cds.sg?fref=photo")).to eq t

        t = "https://www.facebook.com/cds.sg"
        expect(gc("//www.facebook.com/cds.sg?fref=photo")).to eq t

        t = "https://www.cdjapan.co.jp/product/MDR-1012"
        expect(gc("http://www.cdjapan.co.jp/aff/click.cgi/e86NDzbdSLQ/4323/A323439/detailview.html?KEY=MDR-1012")).to eq t

        t = "https://www.charapedia.jp/research/0062/2"
        expect(gc("http://www.sankakucomplex.com/goto/http://www.charapedia.jp/research/0062/2/")).to eq t

        t = "http://myanimelist.net/forum?topicid=1371295"
        expect(gc("https://myanimelist.net/forum/?topicid=1371295&goto=newpost")).to eq t

        t = "https://pc.watch.impress.co.jp/docs/news/yajiuma/20150526_703688.html"
        expect(gc("http://seventhstyle.com/goto/http://pc.watch.impress.co.jp/docs/news/yajiuma/20150526_703688.html")).to eq t

        t = "https://sekainoowari.jp/"
        expect(gc("http://sekainoowari.jp/")).to eq t
    end
end