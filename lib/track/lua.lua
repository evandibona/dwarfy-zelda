local trk  = {}
  trk.tls, trk.obj, trk.item  = {}, {}, {}
  -- t.sandw = { 300, 301, 302, 326, 350, 349, 348, 324 }
  -- t.swater= { 303, 304, 305, 329, 353, 352, 351, 327 }
  -- t.sawa  = { 372, 373, 374, 398, 422, 421, 420, 396 }

  trk.tls.water = 397 
  trk.tls.sand  = 275
  trk.tls.thick = 299
  trk.tls.thin  = 276

  trk.obj.roca = 0 trk.obj.rocb = 1 trk.obj.rocc = 2 trk.obj.rocd = 3
  trk.obj.roka = 4 trk.obj.rokb = 5 trk.obj.rokc = 6 trk.obj.rokd = 7
  trk.obj.shruba, trk.obj.shrubb, trk.obj.shrubc  = 24, 25, 26

  trk.item.knife      = 36
  trk.item.matches    = 37
  trk.item.watermelon = 38
  trk.item.sushi      = 39
  trk.item.silverBar  = 60
  trk.item.silverCoin = 61
  trk.item.goldBar    = 84
  trk.item.goldCoin   = 85

return trk
