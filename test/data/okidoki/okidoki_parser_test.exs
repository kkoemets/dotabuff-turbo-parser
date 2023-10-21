defmodule OkidokiParserTest do
  use ExUnit.Case

  doctest Okidoki.OkidokiParser

  test "get offer elements" do
    assert Okidoki.OkidokiParser.get_offer_links() == [
             ["https://www.okidoki.ee/item/iphone-13-pro-max-gold-128gb/12393804/"],
             ["https://www.okidoki.ee/item/iphone-13-pro-max-128gb-sierra-blue/12350184/"],
             ["https://www.okidoki.ee/item/iphone-13-pro-max/12382669/"],
             ["https://www.okidoki.ee/item/apple-iphone-13-pro-max-128-gb-silver/12390207/"],
             ["https://www.okidoki.ee/item/iphone-13-pro-max-128gb-sierra-blue/12387314/"],
             ["https://www.okidoki.ee/item/iphone-13-pro-max-128-gb/12378233/"],
             ["https://www.okidoki.ee/item/iphone-13-pro-max-128gb-sierra-blue/12373335/"],
             ["https://www.okidoki.ee/item/iphone-13-pro-max/12362911/"],
             ["https://www.okidoki.ee/item/iphone-13-pro-max/12349232/"],
             ["https://www.okidoki.ee/item/iphone-13-pro-max-128gb/12299957/"],
             ["https://www.okidoki.ee/item/apple-iphone-13-pro-max-256gb-garantii/12392241/"],
             ["https://www.okidoki.ee/item/iphone-13-pro-max-256gb/12372302/"],
             ["https://www.okidoki.ee/item/iphone-13-pro-max-256gb-sierra-blue/12354534/"],
             ["https://www.okidoki.ee/item/iphone-13-pro-max-sierra-blue-128gb/12247883/"],
             ["https://www.okidoki.ee/item/iphone-13-pro-max-128gb/12354538/"],
             ["https://www.okidoki.ee/item/iphone-13-pro-max-256-gb-must/12320618/"],
             ["https://www.okidoki.ee/item/iphone-13-pro-max/12298748/"],
             ["https://www.okidoki.ee/item/iphone-13-pro-max/12122746/"],
             ["https://www.okidoki.ee/item/apple-iphone-13-pro-max-128gb-uus-garantii/12373864/"],
             [
               "https://www.okidoki.ee/item/uuevaarne-iphone-13-pro-max-258gb-ja-palju-lisasid-garantii/11785686/"
             ],
             ["https://www.okidoki.ee/item/iphone-13-pro-max-128gb/12376124/"],
             ["https://www.okidoki.ee/item/iphone-13-pro-max-256gb/12361820/"],
             ["https://www.okidoki.ee/item/iphone-13-pro-max-128-gb/12344172/"],
             ["https://www.okidoki.ee/item/iphone-13-pro-max-256-gb/12342333/"],
             ["https://www.okidoki.ee/item/iphone-13-pro-max-128-gb/12374221/"],
             ["https://www.okidoki.ee/item/iphone-13-pro-max-512gb/12367533/"],
             ["https://www.okidoki.ee/item/iphone-13-pro-max-256gb/12330967/"],
             ["https://www.okidoki.ee/item/iphone-13-pro-max-kuldne-128-gb/12284367/"],
             ["https://www.okidoki.ee/item/apple-iphone-13-pro-max-512-gb/12371414/"],
             ["https://www.okidoki.ee/item/iphone-13-pro-max/12381920/"],
             ["https://www.okidoki.ee/item/iphone-13-pro-max-256/12357247/"],
             ["https://www.okidoki.ee/item/apple-iphone-13-pro-max-512gb-gold/11988520/"],
             [
               "https://www.okidoki.ee/item/iphone-13-pro-max-graphite-airpods-umbrised/11852096/"
             ],
             ["https://www.okidoki.ee/item/iphone-13-pro-max-1tb-silver/12364487/"],
             [
               "https://www.okidoki.ee/item/iphone-13-pro-max-1tb-green-excellent-condition/12357900/"
             ]
           ]
  end

  test "get offer details" do
    assert Okidoki.OkidokiParser.get_offer_details(
             "https://www.okidoki.ee/item/iphone-13-pro-max-gold-128gb/12393804/"
           ) ==
             %{
               description:
                 "Müüa töökorras korralik iPhone 13 Pro Max 128GB Sierra Blue\nTelefoni kõik funktsioonid töötavad ning välimus on viisakas.\nBattery Health on 88%\nKaasa tuleb karp ja uus kasutamata usb-c laadimiskaabel.",
               href: "https://www.okidoki.ee/item/iphone-13-pro-max-gold-128gb/12393804/",
               price: "630 €",
               title: "iPhone 13 Pro Max 128GB Sierra Blue"
             }
  end

  test "get offer details with missing data" do
    assert Okidoki.OkidokiParser.get_offer_details("missing_data") ==
             %{
               description: "",
               href: "missing_data",
               price: "",
               title: ""
             }
  end
end
