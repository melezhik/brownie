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
  ]
);
