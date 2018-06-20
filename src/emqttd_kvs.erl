-module(emqttd_kvs).
-include_lib("kvs/include/metainfo.hrl").
-include("emqttd.hrl").
-compile(export_all).

-export([mnesia/1]).

%-boot_mnesia({mnesia, [boot]}).
-copy_mnesia({mnesia, [copy]}).


metainfo() ->   #schema{name=kvs,tables= tables() }.

tables()   -> [ #table{name=mqtt_subproperty,
                       fields=record_info(fields,mqtt_subproperty),
                       copy_type=disc_copies, type=set},

                #table{name=mqtt_subscription,
                       fields=record_info(fields,mqtt_subscription),
                       copy_type=disc_copies, type=bag},

                #table{name=mqtt_subscriber,
                       fields=record_info(fields,mqtt_subscriber),
                       copy_type=disc_copies, type=bag}
              ].

mnesia(copy) ->
    %% Copy Trie Table
    %ok = ekka_mnesia:copy_table(mqtt_subproperty,disc_copies),
    %% Copy Trie Node Table
    %ok = ekka_mnesia:copy_table(mqtt_subscriber,disc_copies),
    %ok = ekka_mnesia:copy_table(mqtt_subscription,disc_copies),
    mnesia:wait_for_tables([ T#table.name || T <- kvs:tables()],infinity),
    [ ekka_mnesia:copy_table(Tab,disc_copies) || #table{name =Tab} <- kvs:tables()].

