%(
  skip-tests => [
   "MoarVM::Remote", # possibly harmless, but scary anyway
   "November", # eats memory
   # These seem to hang and leave some processes behind:
   "IO::Socket::Async::SSL",
   "IRC::Client",
   "Perl6::Ecosystem",           # eats memory
   # These were ignored by Toaster, but reasons are unknown:
   "HTTP::Server::Async",
   "HTTP::Server::Threaded",
   "Log::Minimal",
   "MeCab",
   "Time::Duration",
   "Toaster",
   "Uzu",
   "Russian", # eats memory
   "Sway::Config", # too verbose output, does not fit POST request, 413 Request Entity Too Large
   "Mint", # Install just hang 
   "ParaSeq", # Hangs on at least Rakudo 2025.10
   "SparrowCI - super fun and flexible CI system with many programming languages support", # Typo in the name
    "Web::Scraper", # install hangs forever
    "Test::Time", # hangs during tests - https://github.com/FCO/test-time/issues/2
  ]
);
