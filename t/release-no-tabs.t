
BEGIN {
  unless ($ENV{RELEASE_TESTING}) {
    require Test::More;
    Test::More::plan(skip_all => 'these tests are for release candidate testing');
  }
}

use strict;
use warnings;

# this test was generated with Dist::Zilla::Plugin::Test::NoTabs 0.08

use Test::More 0.88;
use Test::NoTabs;

my @files = (
    'lib/Locale/Babelfish.pm',
    'lib/Locale/Babelfish/Lang/en_US.pm',
    'lib/Locale/Babelfish/Lang/ru_RU.pm',
    'lib/Locale/Babelfish/Maketext.pm',
    't/00-compile.t',
    't/00-report-prereqs.t',
    't/01-basic.t',
    't/author-test-eol.t',
    't/release-distmeta.t',
    't/release-no-tabs.t',
    't/release-pod-coverage.t',
    't/release-pod-syntax.t',
    't/release-test-version.t',
    't/test.en_US.yaml',
    't/test.ru_RU.yaml'
);

notabs_ok($_) foreach @files;
done_testing;
