local trk = {}
  trk.tls = {}
  trk.obj = {}
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


return trk
