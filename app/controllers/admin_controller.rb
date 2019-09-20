class AdminController < ApplicationController
    before_action :generate_uuid

    def generate_uuid
        if @UUID == nil
         params[:UUID] = SecureRandom.uuid
         p params[:UUID]
         @UUID = params[:UUID]
         p @UUID
        end 
    end

    def updating_cookie(cookie, sheaders)
        headers['cookie'] = cookie
        @cookie = cookie
    end

    def parsing(lawyers)
        document = Nokogiri::HTML(lawyers)
        count = document.search('.col-md-12 h4').count
        p count
        @job = document.search('h4 span[class^="label label"]')[0].text
        @nume = document.search('.col-md-12 h4 [style="font-weight:bold;"]')[0].text
        #barou = document.search('.col-md-12 [class="text-nowrap"]')[1].text
        @stare = document.search('h4 span[style^="color:"]')[0].text
        #adress = document.search('.col-md-12 [class="fas fa-map-marker text-red padding-right-sm"]')[1].text
        @phone = document.search('.col-md-12 [class="padding-right-md text-primary"]')[0].text
        @mail = document.search('.col-md-12 [class="text-nowrap"]')[0].text
        p @mail.class
        p @mail.length
    end

    def validation
        if params[:commit] == "OK"
            p "Lawyer OK"
        elsif params[:commit] == "NOT-OK"
            p "Lawyer NOT-OK"
        end
    end

    def search
        load 'app/ifep.rb'
        generate_uuid
        @headers = { 
            "User-Agent" => 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101 Firefox/68.0',
            "X-MicrosoftAjax" => 'Delta=true',
            "Content-Type" => "application/x-www-form-urlencoded",
            "Accept"=>"application/json",
            "cookie" => "_gat=1" 
            }  
        body = "ctl00%24ctl22=ctl00%24MainContent%24upPage&__EVENTTARGET=ctl00%24MainContent%24tbSearch&__EVENTARGUMENT=&__LASTFOCUS=&__VIEWSTATE=%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%2BKDA4LzAxLzIwMTkgMTE6MjA6NDkpPC9mb250Ph4HVG9vbFRpcAUTMDgvMDEvMjAxOSAxMToyMDo0OWRkZGQCDQ8WAh4LXyFJdGVtQ291bnQCGhY0Zg9kFgICAQ9kFgJmDw8WAh8EBTc8ZGl2IGlkPWNvbnRhaW5lcj48dWwgaWQ9YWxwaGFiZXQ%2BPGxpPkE8L2xpPjwvdWw%2BPC9kaXY%2BZGQCAQ9kFgICAQ9kFgJmDw8WAh8EBTc8ZGl2IGlkPWNvbnRhaW5lcj48dWwgaWQ9YWxwaGFiZXQ%2BPGxpPkI8L2xpPjwvdWw%2BPC9kaXY%2BZGQCAg9kFgICAQ9kFgJmDw8WAh8EBTc8ZGl2IGlkPWNvbnRhaW5lcj48dWwgaWQ9YWxwaGFiZXQ%2BPGxpPkM8L2xpPjwvdWw%2BPC9kaXY%2BZGQCAw9kFgICAQ9kFgJmDw8WAh8EBTc8ZGl2IGlkPWNvbnRhaW5lcj48dWwgaWQ9YWxwaGFiZXQ%2BPGxpPkQ8L2xpPjwvdWw%2BPC9kaXY%2BZGQCBA9kFgICAQ9kFgJmDw8WAh8EBTc8ZGl2IGlkPWNvbnRhaW5lcj48dWwgaWQ9YWxwaGFiZXQ%2BPGxpPkU8L2xpPjwvdWw%2BPC9kaXY%2BZGQCBQ9kFgICAQ9kFgJmDw8WAh8EBTc8ZGl2IGlkPWNvbnRhaW5lcj48dWwgaWQ9YWxwaGFiZXQ%2BPGxpPkY8L2xpPjwvdWw%2BPC9kaXY%2BZGQCBg9kFgICAQ9kFgJmDw8WAh8EBTc8ZGl2IGlkPWNvbnRhaW5lcj48dWwgaWQ9YWxwaGFiZXQ%2BPGxpPkc8L2xpPjwvdWw%2BPC9kaXY%2BZGQCBw9kFgICAQ9kFgJmDw8WAh8EBTc8ZGl2IGlkPWNvbnRhaW5lcj48dWwgaWQ9YWxwaGFiZXQ%2BPGxpPkg8L2xpPjwvdWw%2BPC9kaXY%2BZGQCCA9kFgICAQ9kFgJmDw8WAh8EBTc8ZGl2IGlkPWNvbnRhaW5lcj48dWwgaWQ9YWxwaGFiZXQ%2BPGxpPkk8L2xpPjwvdWw%2BPC9kaXY%2BZGQCCQ9kFgICAQ9kFgJmDw8WAh8EBTc8ZGl2IGlkPWNvbnRhaW5lcj48dWwgaWQ9YWxwaGFiZXQ%2BPGxpPko8L2xpPjwvdWw%2BPC9kaXY%2BZGQCCg9kFgICAQ9kFgJmDw8WAh8EBTc8ZGl2IGlkPWNvbnRhaW5lcj48dWwgaWQ9YWxwaGFiZXQ%2BPGxpPks8L2xpPjwvdWw%2BPC9kaXY%2BZGQCCw9kFgICAQ9kFgJmDw8WAh8EBTc8ZGl2IGlkPWNvbnRhaW5lcj48dWwgaWQ9YWxwaGFiZXQ%2BPGxpPkw8L2xpPjwvdWw%2BPC9kaXY%2BZGQCDA9kFgICAQ9kFgJmDw8WAh8EBTc8ZGl2IGlkPWNvbnRhaW5lcj48dWwgaWQ9YWxwaGFiZXQ%2BPGxpPk08L2xpPjwvdWw%2BPC9kaXY%2BZGQCDQ9kFgICAQ9kFgJmDw8WAh8EBTc8ZGl2IGlkPWNvbnRhaW5lcj48dWwgaWQ9YWxwaGFiZXQ%2BPGxpPk48L2xpPjwvdWw%2BPC9kaXY%2BZGQCDg9kFgICAQ9kFgJmDw8WAh8EBTc8ZGl2IGlkPWNvbnRhaW5lcj48dWwgaWQ9YWxwaGFiZXQ%2BPGxpPk88L2xpPjwvdWw%2BPC9kaXY%2BZGQCDw9kFgICAQ9kFgJmDw8WAh8EBTc8ZGl2IGlkPWNvbnRhaW5lcj48dWwgaWQ9YWxwaGFiZXQ%2BPGxpPlA8L2xpPjwvdWw%2BPC9kaXY%2BZGQCEA9kFgICAQ9kFgJmDw8WAh8EBTc8ZGl2IGlkPWNvbnRhaW5lcj48dWwgaWQ9YWxwaGFiZXQ%2BPGxpPlE8L2xpPjwvdWw%2BPC9kaXY%2BZGQCEQ9kFgICAQ9kFgJmDw8WAh8EBTc8ZGl2IGlkPWNvbnRhaW5lcj48dWwgaWQ9YWxwaGFiZXQ%2BPGxpPlI8L2xpPjwvdWw%2BPC9kaXY%2BZGQCEg9kFgICAQ9kFgJmDw8WAh8EBTc8ZGl2IGlkPWNvbnRhaW5lcj48dWwgaWQ9YWxwaGFiZXQ%2BPGxpPlM8L2xpPjwvdWw%2BPC9kaXY%2BZGQCEw9kFgICAQ9kFgJmDw8WAh8EBTc8ZGl2IGlkPWNvbnRhaW5lcj48dWwgaWQ9YWxwaGFiZXQ%2BPGxpPlQ8L2xpPjwvdWw%2BPC9kaXY%2BZGQCFA9kFgICAQ9kFgJmDw8WAh8EBTc8ZGl2IGlkPWNvbnRhaW5lcj48dWwgaWQ9YWxwaGFiZXQ%2BPGxpPlU8L2xpPjwvdWw%2BPC9kaXY%2BZGQCFQ9kFgICAQ9kFgJmDw8WAh8EBTc8ZGl2IGlkPWNvbnRhaW5lcj48dWwgaWQ9YWxwaGFiZXQ%2BPGxpPlY8L2xpPjwvdWw%2BPC9kaXY%2BZGQCFg9kFgICAQ9kFgJmDw8WAh8EBTc8ZGl2IGlkPWNvbnRhaW5lcj48dWwgaWQ9YWxwaGFiZXQ%2BPGxpPlc8L2xpPjwvdWw%2BPC9kaXY%2BZGQCFw9kFgICAQ9kFgJmDw8WAh8EBTc8ZGl2IGlkPWNvbnRhaW5lcj48dWwgaWQ9YWxwaGFiZXQ%2BPGxpPlg8L2xpPjwvdWw%2BPC9kaXY%2BZGQCGA9kFgICAQ9kFgJmDw8WAh8EBTc8ZGl2IGlkPWNvbnRhaW5lcj48dWwgaWQ9YWxwaGFiZXQ%2BPGxpPlk8L2xpPjwvdWw%2BPC9kaXY%2BZGQCGQ9kFgICAQ9kFgJmDw8WAh8EBTc8ZGl2IGlkPWNvbnRhaW5lcj48dWwgaWQ9YWxwaGFiZXQ%2BPGxpPlo8L2xpPjwvdWw%2BPC9kaXY%2BZGQCEw8PFgQeC2N1cnJlbnRQYWdlKClZU3lzdGVtLkludDY0LCBtc2NvcmxpYiwgVmVyc2lvbj00LjAuMC4wLCBDdWx0dXJlPW5ldXRyYWwsIFB1YmxpY0tleVRva2VuPWI3N2E1YzU2MTkzNGUwODkBMR4NT2xkRGF0YUZpbHRlcgU3IFdIRVJFIExhd3llclR5cGUgSU4gKCdEZWZpbml0aXYnLCdTdGFnaWFyJywnU3RyxINpbicpIGQWAmYPZBYCAgEPZBYEAgEPDxYCHwQFXjxmb250IHN0eWxlPSdmb250LXdlaWdodDpib2xkOyc%2BMeKAkzE1PC9mb250PiBkaW4gPGZvbnQgc3R5bGU9J2ZvbnQtd2VpZ2h0OmJvbGQ7Jz4zNDUxMjwvZm9udD5kZAINDw8WAh8EBWEocGFnaW5hIDxmb250IHN0eWxlPSdmb250LXdlaWdodDpib2xkOyc%2BMTwvZm9udD4gZGluIDxmb250IHN0eWxlPSdmb250LXdlaWdodDpib2xkOyc%2BMjMwMTwvZm9udD4pZGQCFQ8WAh8GAg8WHmYPZBYCAgMPFgIeBGhyZWYFL0xhd3llckZpbGUuYXNweD9SZWNvcmRJZD0xNDQ5NiZTaWduYXR1cmU9NjY2NDQ2FhRmDxUBEDAxLTA4LTIwMTkgMTE6MTdkAgEPDxYCHghJbWFnZVVybAUTfi9JbWFnZXMvRGVuaWVkLmdpZmRkAgMPZBYCZg8VAnI8cD5Bdm9jYXR1bCBPTE9TVVRFQU4tTUlDVSBEaWFuYS1NYXJpYSBlc3RlIMOubnNjcmlzIMOubiB1cm3Eg3RvYXJlbGUgcmVnaXN0cmU6IEFjb3JkxIMgYXNpc3RlbsWjxIMganVkaWNpYXLEgzwvcD4eQWNvcmTEgyBhc2lzdGVuxaPEgyBqdWRpY2lhcsSDZAIGDxUBRTxwPkRyZXB0IGRlIGNvbmNsdXppaSBsYTogSnVkZWPEg3RvcmlpLCBUcmlidW5hbGUsIEN1csWjaSBkZSBBcGVsPC9wPmQCBw8PFgIfCgUXfi9JbWFnZXMvM0xldmVsSWNvbi5naWZkZAIJDw8WAh4HVmlzaWJsZWhkZAILDxYCHwQFfTxzcGFuIGNsYXNzPSdmYXMgZmEtdXNlci1jaXJjbGUgcGFkZGluZy1yaWdodC1zbSB0ZXh0LWdyZWVuJz48L3NwYW4%2BPHNwYW4gY2xhc3M9J2xhYmVsIGxhYmVsLXN1Y2Nlc3MnPkF2b2NhdCBkZWZpbml0aXY8L3NwYW4%2BZAIMDxUCTjxmb250IHN0eWxlPSdmb250LXdlaWdodDpib2xkOyc%2BT0xPU1VURUFOLU1JQ1UgRGlhbmEtTWFyaWE8L2ZvbnQ%2BLCBCYXJvdWwgQ2x1ajs8c3BhbiBzdHlsZT0nY29sb3I6cmVkO2ZvbnQtd2VpZ2h0OmJvbGQ7Jz4gW2luYWN0aXZdPC9zcGFuPmQCDQ8WAh8GAgEWAmYPZBYCZg8VBQ9TZWRpdSBwcmluY2lwYWwLQmFyb3VsIENsdWoyQ2x1ai1OYXBvY2EsIFAtxaNhIEF2cmFtIElhbmN1IG5yLjkgYXAuMywganVkLkNsdWoLMDc0Ni4xNzMwNTIWZGlhbmEubWljdUBidWR1c2FuLmNvbWQCDw8PZA8QFgFmFgEWAh4OUGFyYW1ldGVyVmFsdWUFBTE0NDk2FgFmZGQCAQ9kFgICAw8WAh8JBS9MYXd5ZXJGaWxlLmFzcHg%2FUmVjb3JkSWQ9MTM4MTUmU2lnbmF0dXJlPTY2NjQ0NhYUZg8VARAwMS0wOC0yMDE5IDEwOjQzZAIBDw8WAh8KBRh%2BL0ltYWdlcy9EZWZhdWx0SWNvbi5naWZkZAIDDw8WAh8LaGQWAmYPFQJCPHA%2BQXZvY2F0dWwgREVBQyBEYW4gZXN0ZSDDrm5zY3JpcyDDrm4gdXJtxIN0b2FyZWxlIHJlZ2lzdHJlOiA8L3A%2BAGQCBg8VAUU8cD5EcmVwdCBkZSBjb25jbHV6aWkgbGE6IEp1ZGVjxIN0b3JpaSwgVHJpYnVuYWxlLCBDdXLFo2kgZGUgQXBlbDwvcD5kAgcPDxYCHwoFF34vSW1hZ2VzLzNMZXZlbEljb24uZ2lmZGQCCQ8PFgIfC2hkZAILDxYCHwQFfTxzcGFuIGNsYXNzPSdmYXMgZmEtdXNlci1jaXJjbGUgcGFkZGluZy1yaWdodC1zbSB0ZXh0LWdyZWVuJz48L3NwYW4%2BPHNwYW4gY2xhc3M9J2xhYmVsIGxhYmVsLXN1Y2Nlc3MnPkF2b2NhdCBkZWZpbml0aXY8L3NwYW4%2BZAIMDxUCPDxmb250IHN0eWxlPSdmb250LXdlaWdodDpib2xkOyc%2BREVBQyBEYW48L2ZvbnQ%2BLCBCYXJvdWwgQ2x1ajs8c3BhbiBzdHlsZT0nY29sb3I6Z3JlZW47Zm9udC13ZWlnaHQ6Ym9sZDsnPiBbYWN0aXZdPC9zcGFuPmQCDQ8WAh8GAgIWBGYPZBYCZg8VBQ9TZWRpdSBwcmluY2lwYWwLQmFyb3VsIENsdWphVHVyZGEsIHN0ci4gUGlhdGEgUm9tYW5hLCBuci4xMywgYXAuMTEsIGp1ZC4gQ2x1aiwgVGVsOjA3NDUuMzcxMjgyLCBlLW1haWw6ZGFuLmRlYWNfZml2QHlhaG9vLmNvbQowNzQ1MzcxMjgyFmRhbi5kZWFjX2ZpdkB5YWhvby5jb21kAgEPZBYCZg8VBQ9TZWRpdSBwcmluY2lwYWwAYVR1cmRhLCBzdHIuIFBpYXRhIFJvbWFuYSwgbnIuMTMsIGFwLjExLCBqdWQuIENsdWosIFRlbDowNzQ1LjM3MTI4MiwgZS1tYWlsOmRhbi5kZWFjX2ZpdkB5YWhvby5jb20AAGQCDw8PZA8QFgFmFgEWAh8MBQUxMzgxNRYBZmRkAgIPZBYCAgMPFgIfCQUvTGF3eWVyRmlsZS5hc3B4P1JlY29yZElkPTI4ODc4JlNpZ25hdHVyZT02NjY0NDYWFGYPFQEQMDEtMDgtMjAxOSAxMDozOWQCAQ8PFgIfCgUYfi9JbWFnZXMvRGVmYXVsdEljb24uZ2lmZGQCAw8PFgIfC2hkFgJmDxUCUDxwPkF2b2NhdHVsIENJT05DQSBBTEVYQU5EUkEtSU9BTkEgZXN0ZSDDrm5zY3JpcyDDrm4gdXJtxIN0b2FyZWxlIHJlZ2lzdHJlOiA8L3A%2BAGQCBg8VAS88cD5EcmVwdCBkZSBjb25jbHV6aWkgbGE6IFRvYXRlIGluc3RhbsWjZWxlPC9wPmQCBw8PFgIfCgUXfi9JbWFnZXMvNExldmVsSWNvbi5naWZkZAIJDw8WAh8LaGRkAgsPFgIfBAV9PHNwYW4gY2xhc3M9J2ZhcyBmYS11c2VyLWNpcmNsZSBwYWRkaW5nLXJpZ2h0LXNtIHRleHQtZ3JlZW4nPjwvc3Bhbj48c3BhbiBjbGFzcz0nbGFiZWwgbGFiZWwtc3VjY2Vzcyc%2BQXZvY2F0IGRlZmluaXRpdjwvc3Bhbj5kAgwPFQJQPGZvbnQgc3R5bGU9J2ZvbnQtd2VpZ2h0OmJvbGQ7Jz5DSU9OQ0EgQUxFWEFORFJBLUlPQU5BPC9mb250PiwgQmFyb3VsIEJ1Y3VyZcWfdGk7PHNwYW4gc3R5bGU9J2NvbG9yOmdyZWVuO2ZvbnQtd2VpZ2h0OmJvbGQ7Jz4gW2FjdGl2XTwvc3Bhbj5kAg0PFgIfBgICFgRmD2QWAmYPFQUPU2VkaXUgcHJpbmNpcGFsEUJhcm91bCBCdWN1cmXFn3RpV0JkLiBJb24gTWloYWxhY2hlLCBOci4gNzksIEJsLiAxNSwgU2MuIEIsIEV0LiA0LCBBcC4gNzQsIENhbS4gMSwgMiwgU2VjdG9yIDEsIEJ1Y3VyZXN0aQ0wNzI0LjMwNy42OTM7G2FsZXhhbmRyYS5jaW9uY2FAYXBwbGF3LnJvO2QCAQ9kFgJmDxUFD1NlZGl1IHByaW5jaXBhbBFCYXJvdWwgQnVjdXJlxZ90aVdCZC4gSW9uIE1paGFsYWNoZSwgTnIuIDc5LCBCbC4gMTUsIFNjLiBCLCBFdC4gNCwgQXAuIDc0LCBDYW0uIDEsIDIsIFNlY3RvciAxLCBCdWN1cmVzdGkNMDcyNC4zMDcuNjkzOxthbGV4YW5kcmEuY2lvbmNhQGFwcGxhdy5ybztkAg8PD2QPEBYBZhYBFgIfDAUFMjg4NzgWAWZkZAIDD2QWAgIDDxYCHwkFL0xhd3llckZpbGUuYXNweD9SZWNvcmRJZD0xMjgyNCZTaWduYXR1cmU9NjY2NDQ2FhRmDxUBEDAxLTA4LTIwMTkgMTA6MjFkAgEPDxYCHwoFE34vSW1hZ2VzL0RlbmllZC5naWZkZAIDD2QWAmYPFQJ%2FPHA%2BQXZvY2F0dWwgT0FORSBJbG9uYS1HYWJyaWVsYSBlc3RlIMOubnNjcmlzIMOubiB1cm3Eg3RvYXJlbGUgcmVnaXN0cmU6IEN1cmF0b3Igc3BlY2lhbCDFn2kgQWNvcmTEgyBhc2lzdGVuxaPEgyBqdWRpY2lhcsSDPC9wPi9DdXJhdG9yIHNwZWNpYWw7IEFjb3JkxIMgYXNpc3RlbsWjxIMganVkaWNpYXLEg2QCBg8VAS88cD5EcmVwdCBkZSBjb25jbHV6aWkgbGE6IFRvYXRlIGluc3RhbsWjZWxlPC9wPmQCBw8PFgIfCgUXfi9JbWFnZXMvNExldmVsSWNvbi5naWZkZAIJDw8WAh8LaGRkAgsPFgIfBAV9PHNwYW4gY2xhc3M9J2ZhcyBmYS11c2VyLWNpcmNsZSBwYWRkaW5nLXJpZ2h0LXNtIHRleHQtZ3JlZW4nPjwvc3Bhbj48c3BhbiBjbGFzcz0nbGFiZWwgbGFiZWwtc3VjY2Vzcyc%2BQXZvY2F0IGRlZmluaXRpdjwvc3Bhbj5kAgwPFQJHPGZvbnQgc3R5bGU9J2ZvbnQtd2VpZ2h0OmJvbGQ7Jz5PQU5FIElsb25hLUdhYnJpZWxhPC9mb250PiwgQmFyb3VsIERvbGo7PHNwYW4gc3R5bGU9J2NvbG9yOnJlZDtmb250LXdlaWdodDpib2xkOyc%2BIFtpbmFjdGl2XTwvc3Bhbj5kAg0PFgIfBgIBFgJmD2QWAmYPFQUPU2VkaXUgcHJpbmNpcGFsC0Jhcm91bCBEb2xqRG11bi5DcmFpb3ZhLCBzdHIuIERvbGp1bHVpLCBuci4zOSwgYmwuQTYsIHNjLjMsIGFwLjUsIGp1ZC5Eb2xqLCB0ZWwuABNvYW5laWxvbmFAeWFob28uY29tZAIPDw9kDxAWAWYWARYCHwwFBTEyODI0FgFmZGQCBA9kFgICAw8WAh8JBS9MYXd5ZXJGaWxlLmFzcHg%2FUmVjb3JkSWQ9MTM1OTkmU2lnbmF0dXJlPTY2NjQ0NhYWZg8VARAwMS0wOC0yMDE5IDEwOjA2ZAIBDw8WAh8KBRN%2BL0ltYWdlcy9EZW5pZWQuZ2lmZGQCAw8PFgIfC2hkFgJmDxUCSjxwPkF2b2NhdHVsIEFMQlUgU2FuZGEtTHVjaWEgZXN0ZSDDrm5zY3JpcyDDrm4gdXJtxIN0b2FyZWxlIHJlZ2lzdHJlOiA8L3A%2BAGQCBQ8PFgIfC2hkZAIGDxUBLzxwPkRyZXB0IGRlIGNvbmNsdXppaSBsYTogVG9hdGUgaW5zdGFuxaNlbGU8L3A%2BZAIHDw8WAh8KBRd%2BL0ltYWdlcy80TGV2ZWxJY29uLmdpZmRkAgkPDxYCHwtoZGQCCw8WAh8EBX08c3BhbiBjbGFzcz0nZmFzIGZhLXVzZXItY2lyY2xlIHBhZGRpbmctcmlnaHQtc20gdGV4dC1ncmVlbic%2BPC9zcGFuPjxzcGFuIGNsYXNzPSdsYWJlbCBsYWJlbC1zdWNjZXNzJz5Bdm9jYXQgZGVmaW5pdGl2PC9zcGFuPmQCDA8VAkQ8Zm9udCBzdHlsZT0nZm9udC13ZWlnaHQ6Ym9sZDsnPkFMQlUgU2FuZGEtTHVjaWE8L2ZvbnQ%2BLCBCYXJvdWwgQ2x1ajs8c3BhbiBzdHlsZT0nY29sb3I6cmVkO2ZvbnQtd2VpZ2h0OmJvbGQ7Jz4gW2luYWN0aXZdPC9zcGFuPmQCDQ8WAh8GAgEWAmYPZBYCZg8VBQ9TZWRpdSBwcmluY2lwYWwLQmFyb3VsIENsdWpkQ2x1ai1OYXBvY2EsIFNUUi5JLkMuQnLEg3RpYW51IE5SLjQxIEFQLjEsIFRlbDowNzIyLjM2NTQ3MiwgMDc0NS42NjU0NzIsIGUtbWFpbDphdm9jYXRhbGJ1QHlhaG9vLmNvbRkwNzIyLjM2NTQ3MiwgMDc0NS42NjU0NzIsFGF2b2NhdGFsYnVAeWFob28uY29tZAIPDw9kDxAWAWYWARYCHwwFBTEzNTk5FgFmZGQCBQ9kFgICAw8WAh8JBS5MYXd5ZXJGaWxlLmFzcHg%2FUmVjb3JkSWQ9NDcyNyZTaWduYXR1cmU9NjY2NDQ2FhZmDxUBEDAxLTA4LTIwMTkgMDk6NThkAgEPDxYCHwoFGH4vSW1hZ2VzL0RlZmF1bHRJY29uLmdpZmRkAgMPDxYCHwtoZBYCZg8VAkU8cD5Bdm9jYXR1bCBIRVJUQSBDYWxpbiBlc3RlIMOubnNjcmlzIMOubiB1cm3Eg3RvYXJlbGUgcmVnaXN0cmU6IDwvcD4AZAIFDw8WAh8LaGRkAgYPFQEvPHA%2BRHJlcHQgZGUgY29uY2x1emlpIGxhOiBUb2F0ZSBpbnN0YW7Fo2VsZTwvcD5kAgcPDxYCHwoFF34vSW1hZ2VzLzRMZXZlbEljb24uZ2lmZGQCCQ8PFgIfC2hkZAILDxYCHwQFfTxzcGFuIGNsYXNzPSdmYXMgZmEtdXNlci1jaXJjbGUgcGFkZGluZy1yaWdodC1zbSB0ZXh0LWdyZWVuJz48L3NwYW4%2BPHNwYW4gY2xhc3M9J2xhYmVsIGxhYmVsLXN1Y2Nlc3MnPkF2b2NhdCBkZWZpbml0aXY8L3NwYW4%2BZAIMDxUCRTxmb250IHN0eWxlPSdmb250LXdlaWdodDpib2xkOyc%2BSEVSVEEgQ2FsaW48L2ZvbnQ%2BLCBCYXJvdWwgTWFyYW11cmXFnzs8c3BhbiBzdHlsZT0nY29sb3I6Z3JlZW47Zm9udC13ZWlnaHQ6Ym9sZDsnPiBbYWN0aXZdPC9zcGFuPmQCDQ8WAh8GAgEWAmYPZBYCZg8VBQ9TZWRpdSBwcmluY2lwYWwRQmFyb3VsIE1hcmFtdXJlxZ8jQmFpYSBNYXJlLCBHZW9yZ2UgQ29zYnVjIG5yLiAyNUEvMTQKMDcyMjY0MDE0OBcgYXZjYWxpbmhlcnRhQHlhaG9vLmNvbWQCDw8PZA8QFgFmFgEWAh8MBQQ0NzI3FgFmZGQCBg9kFgICAw8WAh8JBS9MYXd5ZXJGaWxlLmFzcHg%2FUmVjb3JkSWQ9MjMwNjYmU2lnbmF0dXJlPTY2NjQ0NhYUZg8VARAwMS0wOC0yMDE5IDA5OjQzZAIBDw8WAh8KBRh%2BL0ltYWdlcy9EZWZhdWx0SWNvbi5naWZkZAIDDw8WAh8LaGQWAmYPFQJCPHA%2BQXZvY2F0dWwgQk9CIEFOQ0EgZXN0ZSDDrm5zY3JpcyDDrm4gdXJtxIN0b2FyZWxlIHJlZ2lzdHJlOiA8L3A%2BAGQCBg8VAS88cD5EcmVwdCBkZSBjb25jbHV6aWkgbGE6IFRvYXRlIGluc3RhbsWjZWxlPC9wPmQCBw8PFgIfCgUXfi9JbWFnZXMvNExldmVsSWNvbi5naWZkZAIJDw8WAh8LaGRkAgsPFgIfBAV9PHNwYW4gY2xhc3M9J2ZhcyBmYS11c2VyLWNpcmNsZSBwYWRkaW5nLXJpZ2h0LXNtIHRleHQtZ3JlZW4nPjwvc3Bhbj48c3BhbiBjbGFzcz0nbGFiZWwgbGFiZWwtc3VjY2Vzcyc%2BQXZvY2F0IGRlZmluaXRpdjwvc3Bhbj5kAgwPFQJCPGZvbnQgc3R5bGU9J2ZvbnQtd2VpZ2h0OmJvbGQ7Jz5CT0IgQU5DQTwvZm9udD4sIEJhcm91bCBCdWN1cmXFn3RpOzxzcGFuIHN0eWxlPSdjb2xvcjpncmVlbjtmb250LXdlaWdodDpib2xkOyc%2BIFthY3Rpdl08L3NwYW4%2BZAINDxYCHwYCAhYEZg9kFgJmDxUFD1NlZGl1IHByaW5jaXBhbBFCYXJvdWwgQnVjdXJlxZ90aUBDYWwuIFBsZXZuZWksIE5yLiAxNDEsIEJsLiAzLCBFdC4gNCwgQXAuIDE0LCBTZWN0b3IgNiwgQnVjdXJlc3RpHTAyMS4zMTMuODcuMzA7IDAyMS4zMTMuOTAuNzg7GGxleGV4cGVydEBiZXN0bGF3eWVycy5yb2QCAQ9kFgJmDxUFD1NlZGl1IHByaW5jaXBhbABAQ2FsLiBQbGV2bmVpLCBOci4gMTQxLCBCbC4gMywgRXQuIDQsIEFwLiAxNCwgU2VjdG9yIDYsIEJ1Y3VyZXN0aQAAZAIPDw9kDxAWAWYWARYCHwwFBTIzMDY2FgFmZGQCBw9kFgICAw8WAh8JBS5MYXd5ZXJGaWxlLmFzcHg%2FUmVjb3JkSWQ9MTY5NyZTaWduYXR1cmU9NjY2NDQ2FhRmDxUBEDAxLTA4LTIwMTkgMDk6MzlkAgEPDxYCHwoFGH4vSW1hZ2VzL0RlZmF1bHRJY29uLmdpZmRkAgMPDxYCHwtoZBYCZg8VAkw8cD5Bdm9jYXR1bCBNT0xET1ZFQU5VIERyYWdvxZ8gZXN0ZSDDrm5zY3JpcyDDrm4gdXJtxIN0b2FyZWxlIHJlZ2lzdHJlOiA8L3A%2BAGQCBg8VAS88cD5EcmVwdCBkZSBjb25jbHV6aWkgbGE6IFRvYXRlIGluc3RhbsWjZWxlPC9wPmQCBw8PFgIfCgUXfi9JbWFnZXMvNExldmVsSWNvbi5naWZkZAIJDw8WAh8LaGRkAgsPFgIfBAV9PHNwYW4gY2xhc3M9J2ZhcyBmYS11c2VyLWNpcmNsZSBwYWRkaW5nLXJpZ2h0LXNtIHRleHQtZ3JlZW4nPjwvc3Bhbj48c3BhbiBjbGFzcz0nbGFiZWwgbGFiZWwtc3VjY2Vzcyc%2BQXZvY2F0IGRlZmluaXRpdjwvc3Bhbj5kAgwPFQJJPGZvbnQgc3R5bGU9J2ZvbnQtd2VpZ2h0OmJvbGQ7Jz5NT0xET1ZFQU5VIERyYWdvxZ88L2ZvbnQ%2BLCBCYXJvdWwgQnJhxZ9vdjs8c3BhbiBzdHlsZT0nY29sb3I6Z3JlZW47Zm9udC13ZWlnaHQ6Ym9sZDsnPiBbYWN0aXZdPC9zcGFuPmQCDQ8WAh8GAgIWBGYPZBYCZg8VBQ9TZWRpdSBwcmluY2lwYWwOQmFyb3VsIEJyYcWfb3YyU2FucGV0cnUgc3RyLiBPbHR1bHVpIG5yLiA0ICAtIHRlbC4g4oCTIDA3MjMyODYyMzkKMDcyMzI4NjIzOQBkAgEPZBYCZg8VBQ9TZWRpdSBwcmluY2lwYWwAMlNhbnBldHJ1IHN0ci4gT2x0dWx1aSBuci4gNCAgLSB0ZWwuIOKAkyAwNzIzMjg2MjM5AABkAg8PD2QPEBYBZhYBFgIfDAUEMTY5NxYBZmRkAggPZBYCAgMPFgIfCQUuTGF3eWVyRmlsZS5hc3B4P1JlY29yZElkPTE2NzQmU2lnbmF0dXJlPTY2NjQ0NhYUZg8VARAwMS0wOC0yMDE5IDA5OjM4ZAIBDw8WAh8KBRh%2BL0ltYWdlcy9EZWZhdWx0SWNvbi5naWZkZAIDDw8WAh8LaGQWAmYPFQJLPHA%2BQXZvY2F0dWwgTUFURUkgUGV0cnUtTWF0ZWkgZXN0ZSDDrm5zY3JpcyDDrm4gdXJtxIN0b2FyZWxlIHJlZ2lzdHJlOiA8L3A%2BAGQCBg8VAS88cD5EcmVwdCBkZSBjb25jbHV6aWkgbGE6IFRvYXRlIGluc3RhbsWjZWxlPC9wPmQCBw8PFgIfCgUXfi9JbWFnZXMvNExldmVsSWNvbi5naWZkZAIJDw8WAh8LaGRkAgsPFgIfBAV9PHNwYW4gY2xhc3M9J2ZhcyBmYS11c2VyLWNpcmNsZSBwYWRkaW5nLXJpZ2h0LXNtIHRleHQtZ3JlZW4nPjwvc3Bhbj48c3BhbiBjbGFzcz0nbGFiZWwgbGFiZWwtc3VjY2Vzcyc%2BQXZvY2F0IGRlZmluaXRpdjwvc3Bhbj5kAgwPFQJIPGZvbnQgc3R5bGU9J2ZvbnQtd2VpZ2h0OmJvbGQ7Jz5NQVRFSSBQZXRydS1NYXRlaTwvZm9udD4sIEJhcm91bCBCcmHFn292OzxzcGFuIHN0eWxlPSdjb2xvcjpncmVlbjtmb250LXdlaWdodDpib2xkOyc%2BIFthY3Rpdl08L3NwYW4%2BZAINDxYCHwYCAhYEZg9kFgJmDxUFD1NlZGl1IHByaW5jaXBhbA5CYXJvdWwgQnJhxZ9vdjJCdi4gc3RyLiBOaWNvbGFlIELEg2xjZXNjdSBuci4gNTMgdGVsLiAwNzIyNTE2NTQxIAowNzIyNTE2NTQxAGQCAQ9kFgJmDxUFD1NlZGl1IHByaW5jaXBhbAAyQnYuIHN0ci4gTmljb2xhZSBCxINsY2VzY3UgbnIuIDUzIHRlbC4gMDcyMjUxNjU0MSAAAGQCDw8PZA8QFgFmFgEWAh8MBQQxNjc0FgFmZGQCCQ9kFgICAw8WAh8JBS5MYXd5ZXJGaWxlLmFzcHg%2FUmVjb3JkSWQ9MTU5MiZTaWduYXR1cmU9NjY2NDQ2FhRmDxUBEDAxLTA4LTIwMTkgMDk6MzhkAgEPDxYCHwoFGH4vSW1hZ2VzL0RlZmF1bHRJY29uLmdpZmRkAgMPZBYCZg8VAns8cD5Bdm9jYXR1bCBHSElUSVUgTG9yZWRhbmEgZXN0ZSDDrm5zY3JpcyDDrm4gdXJtxIN0b2FyZWxlIHJlZ2lzdHJlOiBDdXJhdG9yIHNwZWNpYWwgxZ9pIEFjb3JkxIMgYXNpc3RlbsWjxIMganVkaWNpYXLEgzwvcD4vQ3VyYXRvciBzcGVjaWFsOyBBY29yZMSDIGFzaXN0ZW7Fo8SDIGp1ZGljaWFyxINkAgYPFQEvPHA%2BRHJlcHQgZGUgY29uY2x1emlpIGxhOiBUb2F0ZSBpbnN0YW7Fo2VsZTwvcD5kAgcPDxYCHwoFF34vSW1hZ2VzLzRMZXZlbEljb24uZ2lmZGQCCQ8PFgIfC2hkZAILDxYCHwQFfTxzcGFuIGNsYXNzPSdmYXMgZmEtdXNlci1jaXJjbGUgcGFkZGluZy1yaWdodC1zbSB0ZXh0LWdyZWVuJz48L3NwYW4%2BPHNwYW4gY2xhc3M9J2xhYmVsIGxhYmVsLXN1Y2Nlc3MnPkF2b2NhdCBkZWZpbml0aXY8L3NwYW4%2BZAIMDxUCRjxmb250IHN0eWxlPSdmb250LXdlaWdodDpib2xkOyc%2BR0hJVElVIExvcmVkYW5hPC9mb250PiwgQmFyb3VsIEJyYcWfb3Y7PHNwYW4gc3R5bGU9J2NvbG9yOmdyZWVuO2ZvbnQtd2VpZ2h0OmJvbGQ7Jz4gW2FjdGl2XTwvc3Bhbj5kAg0PFgIfBgICFgRmD2QWAmYPFQUPU2VkaXUgcHJpbmNpcGFsDkJhcm91bCBCcmHFn292NUJ2LiBTdHIuWml6aW51bHVpIG5yLiA4Niwgc2MuIEIsIGFwLiA5IHRlbC4wNzQ3MzUwNTg1CjA3NDczNTA1ODUAZAIBD2QWAmYPFQUPU2VkaXUgcHJpbmNpcGFsADVCdi4gU3RyLlppemludWx1aSBuci4gODYsIHNjLiBCLCBhcC4gOSB0ZWwuMDc0NzM1MDU4NQAAZAIPDw9kDxAWAWYWARYCHwwFBDE1OTIWAWZkZAIKD2QWAgIDDxYCHwkFLkxhd3llckZpbGUuYXNweD9SZWNvcmRJZD0xNTQzJlNpZ25hdHVyZT02NjY0NDYWFGYPFQEQMDEtMDgtMjAxOSAwOTozN2QCAQ8PFgIfCgUYfi9JbWFnZXMvRGVmYXVsdEljb24uZ2lmZGQCAw8PFgIfC2hkFgJmDxUCSzxwPkF2b2NhdHVsIERJTUEgQ8SDbGluLUhvcmlhIGVzdGUgw65uc2NyaXMgw65uIHVybcSDdG9hcmVsZSByZWdpc3RyZTogPC9wPgBkAgYPFQEvPHA%2BRHJlcHQgZGUgY29uY2x1emlpIGxhOiBUb2F0ZSBpbnN0YW7Fo2VsZTwvcD5kAgcPDxYCHwoFF34vSW1hZ2VzLzRMZXZlbEljb24uZ2lmZGQCCQ8PFgIfC2hkZAILDxYCHwQFfTxzcGFuIGNsYXNzPSdmYXMgZmEtdXNlci1jaXJjbGUgcGFkZGluZy1yaWdodC1zbSB0ZXh0LWdyZWVuJz48L3NwYW4%2BPHNwYW4gY2xhc3M9J2xhYmVsIGxhYmVsLXN1Y2Nlc3MnPkF2b2NhdCBkZWZpbml0aXY8L3NwYW4%2BZAIMDxUCSDxmb250IHN0eWxlPSdmb250LXdlaWdodDpib2xkOyc%2BRElNQSBDxINsaW4tSG9yaWE8L2ZvbnQ%2BLCBCYXJvdWwgQnJhxZ9vdjs8c3BhbiBzdHlsZT0nY29sb3I6Z3JlZW47Zm9udC13ZWlnaHQ6Ym9sZDsnPiBbYWN0aXZdPC9zcGFuPmQCDQ8WAh8GAgIWBGYPZBYCZg8VBQ9TZWRpdSBwcmluY2lwYWwOQmFyb3VsIEJyYcWfb3ZCQlYuIHN0ci4gSXVsaXUgTWFuaXUgbnIuIDY4LCBibC4gMywgc2MuIEMsIGFwLiAxIC0gdGVsLiAwNzI0MzIxNjMxCjA3MjQzMjE2MzEAZAIBD2QWAmYPFQUPU2VkaXUgcHJpbmNpcGFsAEJCVi4gc3RyLiBJdWxpdSBNYW5pdSBuci4gNjgsIGJsLiAzLCBzYy4gQywgYXAuIDEgLSB0ZWwuIDA3MjQzMjE2MzEAAGQCDw8PZA8QFgFmFgEWAh8MBQQxNTQzFgFmZGQCCw9kFgICAw8WAh8JBS5MYXd5ZXJGaWxlLmFzcHg%2FUmVjb3JkSWQ9MTQ5OSZTaWduYXR1cmU9NjY2NDQ2FhRmDxUBEDAxLTA4LTIwMTkgMDk6MzdkAgEPDxYCHwoFGH4vSW1hZ2VzL0RlZmF1bHRJY29uLmdpZmRkAgMPZBYCZg8VAmI8cD5Bdm9jYXR1bCBDw4JSU1RFQSBHZW9yZ2V0YS1DYW1lbGlhIGVzdGUgw65uc2NyaXMgw65uIHVybcSDdG9hcmVsZSByZWdpc3RyZTogQ3VyYXRvciBzcGVjaWFsPC9wPg9DdXJhdG9yIHNwZWNpYWxkAgYPFQEvPHA%2BRHJlcHQgZGUgY29uY2x1emlpIGxhOiBUb2F0ZSBpbnN0YW7Fo2VsZTwvcD5kAgcPDxYCHwoFF34vSW1hZ2VzLzRMZXZlbEljb24uZ2lmZGQCCQ8PFgIfC2hkZAILDxYCHwQFfTxzcGFuIGNsYXNzPSdmYXMgZmEtdXNlci1jaXJjbGUgcGFkZGluZy1yaWdodC1zbSB0ZXh0LWdyZWVuJz48L3NwYW4%2BPHNwYW4gY2xhc3M9J2xhYmVsIGxhYmVsLXN1Y2Nlc3MnPkF2b2NhdCBkZWZpbml0aXY8L3NwYW4%2BZAIMDxUCUDxmb250IHN0eWxlPSdmb250LXdlaWdodDpib2xkOyc%2BQ8OCUlNURUEgR2VvcmdldGEtQ2FtZWxpYTwvZm9udD4sIEJhcm91bCBCcmHFn292OzxzcGFuIHN0eWxlPSdjb2xvcjpncmVlbjtmb250LXdlaWdodDpib2xkOyc%2BIFthY3Rpdl08L3NwYW4%2BZAINDxYCHwYCAhYEZg9kFgJmDxUFD1NlZGl1IHByaW5jaXBhbA5CYXJvdWwgQnJhxZ9vdjlGxINnxINyYcWfIGJkLiBVbmlyaWkgYmwuNiwgc2MuIEEsIGFwLjMgLSB0ZWwuIDAyNjgyMTAwNTcKMDI2ODIxMDA1NwBkAgEPZBYCZg8VBQ9TZWRpdSBwcmluY2lwYWwAOUbEg2fEg3JhxZ8gYmQuIFVuaXJpaSBibC42LCBzYy4gQSwgYXAuMyAtIHRlbC4gMDI2ODIxMDA1NwAAZAIPDw9kDxAWAWYWARYCHwwFBDE0OTkWAWZkZAIMD2QWAgIDDxYCHwkFLkxhd3llckZpbGUuYXNweD9SZWNvcmRJZD0xNDc2JlNpZ25hdHVyZT02NjY0NDYWFGYPFQEQMDEtMDgtMjAxOSAwOTozN2QCAQ8PFgIfCgUYfi9JbWFnZXMvRGVmYXVsdEljb24uZ2lmZGQCAw9kFgJmDxUCYzxwPkF2b2NhdHVsIEJVTElHQSBPYW5hIGVzdGUgw65uc2NyaXMgw65uIHVybcSDdG9hcmVsZSByZWdpc3RyZTogQWNvcmTEgyBhc2lzdGVuxaPEgyBqdWRpY2lhcsSDPC9wPh5BY29yZMSDIGFzaXN0ZW7Fo8SDIGp1ZGljaWFyxINkAgYPFQEvPHA%2BRHJlcHQgZGUgY29uY2x1emlpIGxhOiBUb2F0ZSBpbnN0YW7Fo2VsZTwvcD5kAgcPDxYCHwoFF34vSW1hZ2VzLzRMZXZlbEljb24uZ2lmZGQCCQ8PFgIfC2hkZAILDxYCHwQFfTxzcGFuIGNsYXNzPSdmYXMgZmEtdXNlci1jaXJjbGUgcGFkZGluZy1yaWdodC1zbSB0ZXh0LWdyZWVuJz48L3NwYW4%2BPHNwYW4gY2xhc3M9J2xhYmVsIGxhYmVsLXN1Y2Nlc3MnPkF2b2NhdCBkZWZpbml0aXY8L3NwYW4%2BZAIMDxUCQjxmb250IHN0eWxlPSdmb250LXdlaWdodDpib2xkOyc%2BQlVMSUdBIE9hbmE8L2ZvbnQ%2BLCBCYXJvdWwgQnJhxZ9vdjs8c3BhbiBzdHlsZT0nY29sb3I6Z3JlZW47Zm9udC13ZWlnaHQ6Ym9sZDsnPiBbYWN0aXZdPC9zcGFuPmQCDQ8WAh8GAgIWBGYPZBYCZg8VBQ9TZWRpdSBwcmluY2lwYWwOQmFyb3VsIEJyYcWfb3YuUsOuxZ9ub3Ygc3RyLiBWdWxjYW51bHVpIG5yLiA2IHRlbC4gMDc0NTA5NTUwOAowNzQ1MDk1NTA4AGQCAQ9kFgJmDxUFD1NlZGl1IHByaW5jaXBhbAAuUsOuxZ9ub3Ygc3RyLiBWdWxjYW51bHVpIG5yLiA2IHRlbC4gMDc0NTA5NTUwOAAAZAIPDw9kDxAWAWYWARYCHwwFBDE0NzYWAWZkZAIND2QWAgIDDxYCHwkFL0xhd3llckZpbGUuYXNweD9SZWNvcmRJZD0zMDU1OCZTaWduYXR1cmU9NjY2NDQ2FhRmDxUBEDAxLTA4LTIwMTkgMDk6MzZkAgEPDxYCHwoFGH4vSW1hZ2VzL0RlZmF1bHRJY29uLmdpZmRkAgMPDxYCHwtoZBYCZg8VAkY8cD5Bdm9jYXR1bCBST1RBUlUgTWloYWkgZXN0ZSDDrm5zY3JpcyDDrm4gdXJtxIN0b2FyZWxlIHJlZ2lzdHJlOiA8L3A%2BAGQCBg8VAS88cD5EcmVwdCBkZSBjb25jbHV6aWkgbGE6IFRvYXRlIGluc3RhbsWjZWxlPC9wPmQCBw8PFgIfCgUXfi9JbWFnZXMvNExldmVsSWNvbi5naWZkZAIJDw8WAh8LaGRkAgsPFgIfBAV9PHNwYW4gY2xhc3M9J2ZhcyBmYS11c2VyLWNpcmNsZSBwYWRkaW5nLXJpZ2h0LXNtIHRleHQtZ3JlZW4nPjwvc3Bhbj48c3BhbiBjbGFzcz0nbGFiZWwgbGFiZWwtc3VjY2Vzcyc%2BQXZvY2F0IGRlZmluaXRpdjwvc3Bhbj5kAgwPFQJDPGZvbnQgc3R5bGU9J2ZvbnQtd2VpZ2h0OmJvbGQ7Jz5ST1RBUlUgTWloYWk8L2ZvbnQ%2BLCBCYXJvdWwgQnJhxZ9vdjs8c3BhbiBzdHlsZT0nY29sb3I6Z3JlZW47Zm9udC13ZWlnaHQ6Ym9sZDsnPiBbYWN0aXZdPC9zcGFuPmQCDQ8WAh8GAgIWBGYPZBYCZg8VBQ9TZWRpdSBwcmluY2lwYWwOQmFyb3VsIEJyYcWfb3Y1QnYuIHN0ci4gSXVsaXUgTWFuaXUgbnIuIDMyLCBjYW0uIDE1IC10ZWwuIDA3NTIxNzc3OTEKMDc4NjU1MDU1MABkAgEPZBYCZg8VBQ9TZWRpdSBwcmluY2lwYWwANUJ2LiBzdHIuIEl1bGl1IE1hbml1IG5yLiAzMiwgY2FtLiAxNSAtdGVsLiAwNzUyMTc3NzkxAABkAg8PD2QPEBYBZhYBFgIfDAUFMzA1NTgWAWZkZAIOD2QWAgIDDxYCHwkFL0xhd3llckZpbGUuYXNweD9SZWNvcmRJZD0yOTk1MCZTaWduYXR1cmU9NjY2NDQ2FhRmDxUBEDAxLTA4LTIwMTkgMDk6MzJkAgEPDxYCHwoFGH4vSW1hZ2VzL0RlZmF1bHRJY29uLmdpZmRkAgMPDxYCHwtoZBYCZg8VAko8cD5Bdm9jYXR1bCBIQUhBTUlBTiBTSVJBTlVTIGVzdGUgw65uc2NyaXMgw65uIHVybcSDdG9hcmVsZSByZWdpc3RyZTogPC9wPgBkAgYPFQEvPHA%2BRHJlcHQgZGUgY29uY2x1emlpIGxhOiBUb2F0ZSBpbnN0YW7Fo2VsZTwvcD5kAgcPDxYCHwoFF34vSW1hZ2VzLzRMZXZlbEljb24uZ2lmZGQCCQ8PFgIfC2hkZAILDxYCHwQFfTxzcGFuIGNsYXNzPSdmYXMgZmEtdXNlci1jaXJjbGUgcGFkZGluZy1yaWdodC1zbSB0ZXh0LWdyZWVuJz48L3NwYW4%2BPHNwYW4gY2xhc3M9J2xhYmVsIGxhYmVsLXN1Y2Nlc3MnPkF2b2NhdCBkZWZpbml0aXY8L3NwYW4%2BZAIMDxUCSjxmb250IHN0eWxlPSdmb250LXdlaWdodDpib2xkOyc%2BSEFIQU1JQU4gU0lSQU5VUzwvZm9udD4sIEJhcm91bCBCdWN1cmXFn3RpOzxzcGFuIHN0eWxlPSdjb2xvcjpncmVlbjtmb250LXdlaWdodDpib2xkOyc%2BIFthY3Rpdl08L3NwYW4%2BZAINDxYCHwYCARYCZg9kFgJmDxUFD1NlZGl1IHByaW5jaXBhbBFCYXJvdWwgQnVjdXJlxZ90aUZCZC4gTWFyZXNhbCBBbGV4YW5kcnUgQXZlcmVzY3UsIE5yLiAxNSBCL0MsIEV0LiA2LCBTZWN0b3IgMSwgQnVjdXJlc3RpDTAzNzQuNDk0Ljk0NDsUb2ZmaWNlQHN1Y2l1cG9wYS5ybztkAg8PD2QPEBYBZhYBFgIfDAUFMjk5NTAWAWZkZBgBBR5fX0NvbnRyb2xzUmVxdWlyZVBvc3RCYWNrS2V5X18WGgUZY3RsMDAkTWFpbkNvbnRlbnQkY2tBbGwkMAUZY3RsMDAkTWFpbkNvbnRlbnQkY2tBbGwkMQUZY3RsMDAkTWFpbkNvbnRlbnQkY2tBbGwkMgUZY3RsMDAkTWFpbkNvbnRlbnQkY2tBbGwkMwUZY3RsMDAkTWFpbkNvbnRlbnQkY2tBbGwkNAUZY3RsMDAkTWFpbkNvbnRlbnQkY2tBbGwkNQUZY3RsMDAkTWFpbkNvbnRlbnQkY2tBbGwkNgUZY3RsMDAkTWFpbkNvbnRlbnQkY2tBbGwkNgUcY3RsMDAkTWFpbkNvbnRlbnQkY2tTdGF0dXMkMAUcY3RsMDAkTWFpbkNvbnRlbnQkY2tTdGF0dXMkMQUcY3RsMDAkTWFpbkNvbnRlbnQkY2tTdGF0dXMkMQUmY3RsMDAkTWFpbkNvbnRlbnQkY2JMYXdQcmFjdGljZUZvcm1zJDAFJmN0bDAwJE1haW5Db250ZW50JGNiTGF3UHJhY3RpY2VGb3JtcyQxBSZjdGwwMCRNYWluQ29udGVudCRjYkxhd1ByYWN0aWNlRm9ybXMkMgUmY3RsMDAkTWFpbkNvbnRlbnQkY2JMYXdQcmFjdGljZUZvcm1zJDMFJmN0bDAwJE1haW5Db250ZW50JGNiTGF3UHJhY3RpY2VGb3JtcyQ0BSZjdGwwMCRNYWluQ29udGVudCRjYkxhd1ByYWN0aWNlRm9ybXMkNAUnY3RsMDAkTWFpbkNvbnRlbnQkY2JDb25jbHVzaW9uc1JpZ2h0cyQwBSdjdGwwMCRNYWluQ29udGVudCRjYkNvbmNsdXNpb25zUmlnaHRzJDEFJ2N0bDAwJE1haW5Db250ZW50JGNiQ29uY2x1c2lvbnNSaWdodHMkMgUnY3RsMDAkTWFpbkNvbnRlbnQkY2JDb25jbHVzaW9uc1JpZ2h0cyQyBSNjdGwwMCRNYWluQ29udGVudCRjYkluZm9SZWdpc3RlcnMkMAUjY3RsMDAkTWFpbkNvbnRlbnQkY2JJbmZvUmVnaXN0ZXJzJDEFI2N0bDAwJE1haW5Db250ZW50JGNiSW5mb1JlZ2lzdGVycyQyBSNjdGwwMCRNYWluQ29udGVudCRjYkluZm9SZWdpc3RlcnMkMgUdY3RsMDAkTWFpbkNvbnRlbnQkY2tMYXN0VmlzaXR03zEkM2NccsypOv5GtQViN%2Ff0ABqG6fUgNnyVh23ZFw%3D%3D&__VIEWSTATEGENERATOR=EE7875AC&__EVENTVALIDATION=%2FwEdAKUBNewZV%2FAqY4MwUBV4jQiZ1Afhu6SbAwaJV4cC6i2BD9ZAMtdODLtuXTW8lggqX4l4FaaPMbLmkqVFt3otRw1ai5fWKp7umKakMydhPtIZVhuI5eIf2u%2FujKBqBwBYw59MmPbgEfY5sdCWc94Hn81TRyr2ruRoGrf%2FWFXPP1QVY3LQQNXHgGh1rZo3yoVSMMYaDOi9Pqh8XugcrbRNnnWJVtBqbWVlI24V%2F1RbAaX7Pzhnd65sHNT%2Bqy9%2F%2FV%2BBrsshj1k%2BWq9XkOjnHB5bx2lQvkRS2TjgRC7qUwrlWv%2BoPd3ZrQQXkZ%2FxWnIgLNu4GBFuo0Nl5if%2Ftxb%2BwlejWkjQQgKv%2BL%2FrfF4NLhtqMYbjl7yhlA8NCw0C4BtVdLe8CFh2wSO3MjbTzDRzMEcQNXZKS5453zRiMzb9SeXuT2nuLM4%2FruWTyt%2B09ApD%2Fkjw1X7z%2B5mGLRdaLWnG5vTcXkd4037cI6%2BK65pjliKCJzz5qBM9Js%2BndBCzt07Gmh%2BNAvRlHyGbkm%2BdzRc8wZZEsEJHUzMujx6YLRaRRYeO6J%2FF9Nyaa9neo07U8I8ELpSgY6DeG6LRMMUmsXW8eeDe0Ubeqm9J257CDO489eljuXT1MGZOzf630z4uKOuR4%2FPoYDJdXInqRJVi3VuQJVPfEeCGEwq%2BYSPx44cV1fkVgZR8CjaNIWy27asSA4Jfx6bA2L0VnP%2BSEwVTp9jmACc79lZ611X7BZ8CjGJqkyjTKu6RyLxshV%2Fh2Q7i3%2B5%2Bv0Hl3NR9IheYXYwu8OLf8P%2BRj9MWfNmzfr2bj6nbWx20ctwJaNTCNHDpJgWRjz3DsYnkNGGyJLR1ZpxZZjQtmFvJlPLRmf5PJYSxO9uwGUpB9WzJb9wCrFPRbuhNAMPNvW6xiXUx%2F2HNc8JjN5s3X9nQQowx63o35L2J%2FFuOaAUnDf0az%2FgTQo5M3U5ak6cXoNUOVtDGXJhcDuJSto%2F6kRm2tBolsuRN1zRYBUK1zzWjKmVdG4Xggn3i6TggHkECEFYX0uQOs8WqHcBWgkB%2BGwSopvChsMpPX8468%2FVgWNvzWbcHvDnZwuTK%2FRbebQeFWKdYtLOnvj%2B5IoN2NHpBCPwsMFW0CtYLtHRZ58egffLdOn8tGgv9qPA0J4bbRlTpz54%2BDpmCrH%2BmpZGPLN0Pjsvjtd60qcPfrJfwXbdgWjsdAvEcRZ%2B%2F9%2ByuwbesRxNwKK3TPYWKjFYYgDBM%2Bt%2F2VHpC28pFJ23RX7eP9jrtL34Bfg4a6uUFIXZP0u2N1iWG%2BPtYPTocPj4UMwIzCug%2BSb1cJXovC%2B7C%2BZliOLzuJ00GF1mUmOHlMeZ68rBUWW5XKA8x6eqwICBVPQtSOQkmCm5FCO9SyTTMwD1avUpcqeWMBQQiGzQKTZMoPAIq3Vj4P2x%2BucKFmh1TEJuJMDJAEpSICdq0LXdIdS%2Bg8Ts3m0MD4oTtjjzuMQ00oFHyIq4%2FpxioLdF1rfc18AlyKvANSUUbIRp5%2B5C9SAwUWqqOg7pJmdpETFhFKAwM2iGrONQ%2Bo0ZI9g%2F2k1nY1Fb17PbXSkjggRhh5k4Ya7Ikd3%2B0h91AHsh09ygNhfmGrEpPpvzrGVJO2oTMWM7uR5w4t6e1f%2FKoT6Zcl6Fn90kgMIGkNeD22lijCXyEiqu8Ek43DegqXqERL1zcR%2BMCbSyeWvrJQc6VSXnxAOuR50wDJ0JLR9Wn61L16FZwjdzYJFK0J95NFbZ66tNJNfhiMLIFgQ21GkoR5KQZh2DQ1XLxaPCd%2F0%2FHPz4end%2BlSXG6GZNyApE1%2FOHQMcDu0sKW0TtXLz9AFDnBvxbGpo9OG4H6ZwflGnkvbkm4qJ2fACE8fYQiFuvKML0LzqdxOvs8codMmmrvFb7xPWVSS0ylC9OXlT60ZVu%2BSpJSC8vjSMwtdOn4MNP2%2BjJxi96OGcFRdYDXf6acNeKwDk0YhtFWhQxy%2Bq8IOLWDOy2ng1lw8xz7RmKxZnY2K2Mh5HZV8alwoenlgHPob8%2F3vWNU33G49G8Y3M%2BLgvw9%2F3kVTgUc6PqNOKXvZjGJr3IroCrjWnW3uqvbioKvlJdqNlMh9rVtRGX7943nFdswCoVqsDli%2FuWzgkYhX5xYl2HlQUiHYKe9CbO%2F%2BFXUYOmhBAa4UT1N38r7e%2FgnMduuxVUdo0tej71SaWEkcdlKcsPBH5NC4%2BsOE0uS6psRKk72E9Od7CKEncZlJnJrx2s16O4ZiY6NojIxrVZPW%2Fqd%2B8W2y2PnIqLv4NqxztPCWXmbXhLmS3kDtHBxJol1DmhBlCerbiM3TMbbvGPbkd%2Fn7v0vsGM85Za6%2BVjPDNqtXvSAQt%2FRCVFwWWPMznL5RRXmkm%2F6%2BUBgslwmZhjNA2Nie321fJhvhjtx9hrj%2BFKF921ixThWLW3Y4%2Fk8sDV%2F7DfVu8Xnv9a%2BYJcWYekTSmfT0oDitMMsPZ6ytp4%2FThHQfFHqwG8LUUCKcyvHKzp92DdVSD0Xc6rc%2Bo%2BQzRppDfzZATIEtCipoURUr03ROZgeDroKodeAoh%2Bbm1Ffyk8qdqWEC1mGuPqyQr7idReTkKhh0W8eU7vXxpy1SPx3%2BrqdxC6MVTt%2FYWzz4KCUX5lsX36ttDF%2F%2F1lMiey8hMouLqAxC17%2Bur4lRxitlCukIqmA3VZnb7vucy5bffAs7A0nKjA21sbCqj4kVjK%2BWePzAfEVpOGVZ0YZKJFGwypPnf5oZkaGdaSBvygGnTkVeM1U5wTZRbiKn61d8jtkyQ6zOVC144ApQiR7o1JqmV1XJ8qpi9D%2FuaC%2F3kU36CPNNrK5Y%2F7rH%2FUewLTKpv2OJGBycVXeYC2oHRAxK9TlU6RvgvARHKGxcPvxRg3C4KhFxXx3867z9rWViM5qtn9R8OjIIBhvt8yJBWzi8PyRbXm1h8QLhe3UAydcCjZVm4V%2B0eaKszaEIyYD%2BBNasxlc8msoyZsc0l9zmAQWGJxm6s%2FYST4wUtQhDyJFTZkTV7fGzcUbcAz1uwVFv9fiuWg5x5Q5Bn7JiwnKOr1qk9aeNjy22s1fl1p496OMTxa8xlX1egHCmyhN8wsSXxRWwjWc%2FF2mzNnvsj%2BpKXKV7E%2Fo32V%2F2ttrXBNWKabWU5kNrxdxnsfrsizPmPYkqoOwpzb1GREPLB%2BD%2FhyeutE0IwLbbOGeHIl6xg5tSr0ofWiDlqjBlNGy5DMy%2FeeRA0sNNONqRGNk9KV6xiGRVdjlX0aARNCj6DEq4kKYte0sGmT6i0Ka8YmcT%2F99OyUqnOYcHOZC328bzCDsn5GVv5oHhrkIVz1rGgXVsGuKeFCEee3D0ZSi%2BVtjY%2FuJRiMnaWLbGqLcTYUSREXMK2QVwssTY5%2B%2BGHyZFnWcwK0gCzvfi1KNpm%2B3k8Gklov2KgyrSVmH5YYSNZe23Fm7ZQwwpx2LM4r%2BkE%2Fq8CSpEQSLfrH26NSRe5N3Zu%2BVd0UMGdlLld7TWREmBRrWBHD99rtpC7oQvVUhrmMyBr9cFYAXwLReY6YnbmIhFcNPtSteXU0gNr3HfP7qr2heF2wiZqhw2vBVEPkM8tefFnCh73KXf4%2BrkE3k3bSRdNuKRn64744l1fE%3D&ctl00%24MainContent%24hfLeft=&ctl00%24MainContent%24ddlRecords=30&ctl00%24MainContent%24ddlCompany=0&ctl00%24MainContent%24ckAll%240=0&ctl00%24MainContent%24tbNoDays=&ctl00%24MainContent%24tbDataStart=&ctl00%24MainContent%24tbDataStop=&ctl00%24MainContent%24tbSearch=teodor&ctl00%24MainContent%24ddlOrderBy=last_update&ctl00%24MainContent%24ddlOrderType=DESC&ctl00%24MainContent%24PagerTop%24tbPage=1&ctl00%24MainContent%24repLawyers%24ctl00%24hfLawyerId=14496&ctl00%24MainContent%24repLawyers%24ctl01%24hfLawyerId=13815&ctl00%24MainContent%24repLawyers%24ctl02%24hfLawyerId=28878&ctl00%24MainContent%24repLawyers%24ctl03%24hfLawyerId=12824&ctl00%24MainContent%24repLawyers%24ctl04%24hfLawyerId=13599&ctl00%24MainContent%24repLawyers%24ctl05%24hfLawyerId=4727&ctl00%24MainContent%24repLawyers%24ctl06%24hfLawyerId=23066&ctl00%24MainContent%24repLawyers%24ctl07%24hfLawyerId=1697&ctl00%24MainContent%24repLawyers%24ctl08%24hfLawyerId=1674&ctl00%24MainContent%24repLawyers%24ctl09%24hfLawyerId=1592&ctl00%24MainContent%24repLawyers%24ctl10%24hfLawyerId=1543&ctl00%24MainContent%24repLawyers%24ctl11%24hfLawyerId=1499&ctl00%24MainContent%24repLawyers%24ctl12%24hfLawyerId=1476&ctl00%24MainContent%24repLawyers%24ctl13%24hfLawyerId=30558&ctl00%24MainContent%24repLawyers%24ctl14%24hfLawyerId=29950&hiddenInputToUpdateATBuffer_CommonToolkitScripts=1&__ASYNCPOST=true&:"
        @body = body.gsub(/(?<=tbSearch=)\w+(?=\&)/, params[:term])
        command = Ifep::ObtainCookie.call(@headers)
        if command.success?  
            cookie = command.result 
            headers = updating_cookie(cookie, headers)
            puts "COMMENCING DATA FETCHING"
            command = Ifep::Lawyers.call(@headers, @body)
            if command.success?
                lawyers = command.result 
                parsing(lawyers)
            else
                puts command.errors[:fetch_lawyers]
            end
        else
            puts command.errors[:fetch_cookie]
        end
        
    end
    
end
