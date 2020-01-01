TIMEFORMAT=%U

CFLAGS += -Wall -Wpedantic -Wextra -O2 

all: wc2a wc2u wc2o wcdiff wctool wcstream

wc2a: wc2a.c
	$(CC) $(CFLAGS) $< -o $@

wc2u: wc2u.c
	$(CC) $(CFLAGS) $< -o $@

wc2o: wc2o.c
	$(CC) $(CFLAGS) $< -o $@

wcdiff: wcdiff.c
	$(CC) $(CFLAGS) $< -o $@

wctool: wctool.c
	$(CC) $(CFLAGS) $< -o $@

wcstream: wcstream.c
	$(CC) $(CFLAGS) $< -o $@

pocorgtfo18.pdf:
	curl -L --retry 20 --retry-delay 2 -O https://github.com/angea/pocorgtfo/raw/master/releases/pocorgtfo18.pdf

ascii.txt: wctool
	@./wctool a > ascii.txt

utf8.txt: wctool
	@./wctool --utf8 > utf8.txt

space.txt: wctool
	@./wctool --allspace > space.txt

word.txt: wctool
	@./wctool --allword > word.txt

bench: pocorgtfo18.pdf wc2a wc2u ascii.txt utf8.txt space.txt word.txt
	@./bench.sh wc -lwc pocorgtfo18.pdf
	@./bench.sh wc -lwm pocorgtfo18.pdf
	@./bench.sh wc -lwc ascii.txt
	@./bench.sh wc -lwm utf8.txt
	@./bench.sh wc -lwc space.txt
	@./bench.sh wc -lwm space.txt
	@./bench.sh wc -lwc word.txt
	@./bench.sh wc -lwm word.txt
	@./bench.sh ./wc2a -lwc pocorgtfo18.pdf
	@./bench.sh ./wc2a -lwc ascii.txt
	@./bench.sh ./wc2a -lwm utf8.txt
	@./bench.sh ./wc2a -lwcP pocorgtfo18.pdf
	@./bench.sh ./wc2u -lwm pocorgtfo18.pdf
	@./bench.sh ./wc2u -lwm ascii.txt
	@./bench.sh ./wc2u -lwm utf8.txt
	@./bench.sh ./wc2u -lwmP pocorgtfo18.pdf

bench10: pocorgtfo18.pdf wc2a wc2u ascii.txt utf8.txt space.txt word.txt
	@./bench10.sh wc -lwc pocorgtfo18.pdf
	@./bench10.sh wc -lwm pocorgtfo18.pdf
	@./bench10.sh wc -lwc ascii.txt
	@./bench10.sh wc -lwm utf8.txt
	@./bench10.sh wc -lwc space.txt
	@./bench10.sh wc -lwm space.txt
	@./bench10.sh wc -lwc word.txt
	@./bench10.sh wc -lwm word.txt
	@./bench10.sh ./wc2a -lwc pocorgtfo18.pdf
	@./bench10.sh ./wc2a -lwc ascii.txt
	@./bench10.sh ./wc2a -lwm utf8.txt
	@./bench10.sh ./wc2a -lwcP pocorgtfo18.pdf
	@./bench10.sh ./wc2u -lwm pocorgtfo18.pdf
	@./bench10.sh ./wc2u -lwm ascii.txt
	@./bench10.sh ./wc2u -lwm utf8.txt
	@./bench10.sh ./wc2u -lwmP pocorgtfo18.pdf


test: wc2a
	@bash selftest

clean:
	rm -f wc2a wc2u wc2o wcdiff wctool wcstream

cleanall: 
	rm -f pocorgtfo18.pdf ascii.txt utf8.txt word.txt
