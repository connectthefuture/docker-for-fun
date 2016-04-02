#!/usr/bin/env python
# -*- encoding: utf-8 -*-
# Created on 2016-03-01 09:29:06
# Project: yimaitongdupianhui
#!/usr/bin/env python
# -*- encoding: utf-8 -*-
# Created on 2016-03-01 02:53:47
# Project: yimaitongdupianhui

from pyspider.libs.base_handler import *

import re

class Handler(BaseHandler):
    crawl_config = {
    }

    @every(minutes=24 * 60)
    def on_start(self):
        self.crawl('http://case.medlive.cn/all/case-imageology/list.html?ver=branch', callback=self.index_page)
        
    @config(age=24 * 60 * 60)

    def index_page(self, response):

        for each in response.doc('SPAN.flip_total').items():
            url_prefix = "http://case.medlive.cn/all/case-imageology/list.html?ver=branch&page="
            total_no = response.doc('SPAN.flip_total').text().split('&nbsp;')[0]
            print total_no            
            toremove = dict.fromkeys((ord(c) for c in u'\xa0\n\t '))
            total_pages = int(re.findall(r"\d+\.?\d*",total_no.translate(toremove))[0])

            

            for i in range(1, total_pages+1):

                i = repr(i)

                url = url_prefix+i+ '.html'


                self.crawl(url, callback=self.test_page)    
                
    def test_page(self, response):
        for each in response.doc('a[href^="http"]').items():
                if re.match(".*case-article.*", each.attr.href):
                    url = "http://case.medlive.cn"+each.attr.href
                self.crawl(each.attr.href, callback=self.detail_page)
                
    @config(age=24 * 60 * 60)

    def mouye_keshi_page(self, response):
        for each in response.doc('a[href^="http://case.medlive.cn/.*/case-article"]').items():
            self.crawl(each.attr.href, callback=self.detail_page)


    @config(priority=2)
    def detail_page(self, response):
        return {
            "url": response.url,
            "title": response.doc('title').text(),
            "tiezi_leixing_quancheng":response.doc('DIV.crumbNav').text(),
            "tiezi_leixing_bankuai":response.doc('DIV.crumbNav').text().split(">")[1],
            "tiezi_leixing_keshileixing":response.doc('DIV.crumbNav').text().split(">")[0],
            "publish_time":response.doc('DIV.title_cms>span:eq(0)').text().split(" ")[0],
            "publish_person":response.doc('DIV.title_cms>span>a.color_888').text(),
            "case_article_pics":[x.attr.src for x in response.doc('img#big_img.jqzoom').items()],
            "case_article_case_result":response.doc('.case_result').text(),
            "case_article_comments": [{
                "user": x('dd:eq(0)>a').text(),
                "time": x('dd:eq(0)>span').text(),
                "content": x('dd:eq(1)').text(),
                "replies":[{
                "reply_user": y('.com_user').text(),
                "reply_user_content": y('.com_user_say').text()
                }for y in x('.com_return').items()]

            } for x in response.doc('div.inc_c:nth-child(5)>dl').items()]

        }

