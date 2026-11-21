--[[
  BABFT_AutoFarm_v1  protected build
  Loader: fetch parts -> xor -> lzss -> run
]]
local _qD0YTwT={
"https://raw.githubusercontent.com/fhuev12/BABFT-Scripts/main/parts/BABFT_AutoFarm_v1.p1.txt",
"https://raw.githubusercontent.com/fhuev12/BABFT-Scripts/main/parts/BABFT_AutoFarm_v1.p2.txt",
"https://raw.githubusercontent.com/fhuev12/BABFT-Scripts/main/parts/BABFT_AutoFarm_v1.p3.txt",
"https://raw.githubusercontent.com/fhuev12/BABFT-Scripts/main/parts/BABFT_AutoFarm_v1.p4.txt"
}
local _eqBmpve={}
for _y4nPFMh=1,#_qD0YTwT do
  local _JejALLP=game:HttpGet(_qD0YTwT[_y4nPFMh])
  _eqBmpve[#_eqBmpve+1]=_JejALLP
end
local _0nmNPLj=table.concat(_eqBmpve):gsub('%s+','')
local _7UIwudX='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
local _IyU2knQ={}
for _y4nPFMh=1,#_7UIwudX do _IyU2knQ[_7UIwudX:sub(_y4nPFMh,_y4nPFMh)]=_y4nPFMh-1 end
local function _ZtGvYJj(_SsLQplD)
  local _VabJBmA={}
  local _vcea8or=#_SsLQplD
  local _y4nPFMh=1
  while _y4nPFMh<=_vcea8or do
    local _63kYFiq=_IyU2knQ[_SsLQplD:sub(_y4nPFMh,_y4nPFMh)]
    local _HrGvWp7=_IyU2knQ[_SsLQplD:sub(_y4nPFMh+1,_y4nPFMh+1)]
    local _vdkGS7U=_SsLQplD:sub(_y4nPFMh+2,_y4nPFMh+2)
    local _7vE5wFa=_SsLQplD:sub(_y4nPFMh+3,_y4nPFMh+3)
    local _p2yp4EE=(_vdkGS7U=='=') and -1 or _IyU2knQ[_vdkGS7U]
    local _SmqkepB=(_7vE5wFa=='=') and -1 or _IyU2knQ[_7vE5wFa]
    if not (_63kYFiq and _HrGvWp7) then break end
    _VabJBmA[#_VabJBmA+1]=string.char(_63kYFiq*4+math.floor(_HrGvWp7/16))
    if _p2yp4EE and _p2yp4EE>=0 then
      _VabJBmA[#_VabJBmA+1]=string.char((_HrGvWp7%16)*16+math.floor(_p2yp4EE/4))
      if _SmqkepB and _SmqkepB>=0 then
        _VabJBmA[#_VabJBmA+1]=string.char((_p2yp4EE%4)*64+_SmqkepB)
      end
    end
    _y4nPFMh=_y4nPFMh+4
  end
  return table.concat(_VabJBmA)
end
local _oA5nGvW='sxKHFb_qnqOgESLO0KUb5c0x417f'
local _K68b0zd=bit32
local function _ubgzwhW(_SsLQplD)
  local _VabJBmA={}
  local _d2FjkSu=#_oA5nGvW
  for _y4nPFMh=1,#_SsLQplD do
    _VabJBmA[_y4nPFMh]=string.char(_K68b0zd.bxor(string.byte(_SsLQplD,_y4nPFMh),string.byte(_oA5nGvW,(_y4nPFMh-1)%_d2FjkSu+1)))
  end
  return table.concat(_VabJBmA)
end
local function _c5whVPY(_SsLQplD)
  local _VabJBmA={}
  local _y4nPFMh=1
  local _zFg5v4u=0
  local _pgZ1Jvr=0
  while _y4nPFMh<=#_SsLQplD do
    if _pgZ1Jvr==0 then _zFg5v4u=string.byte(_SsLQplD,_y4nPFMh);_y4nPFMh=_y4nPFMh+1;_pgZ1Jvr=8 end
    if _K68b0zd.band(_zFg5v4u,1)==1 then
      local _l8wwBKJ=string.byte(_SsLQplD,_y4nPFMh)*256+string.byte(_SsLQplD,_y4nPFMh+1)
      local _85BRpAS=string.byte(_SsLQplD,_y4nPFMh+2)
      _y4nPFMh=_y4nPFMh+3
      local _DlklmMt=#_VabJBmA-_l8wwBKJ
      for _pdRxOdE=1,_85BRpAS do _VabJBmA[#_VabJBmA+1]=_VabJBmA[_DlklmMt+_pdRxOdE] end
    else
      _VabJBmA[#_VabJBmA+1]=string.sub(_SsLQplD,_y4nPFMh,_y4nPFMh)
      _y4nPFMh=_y4nPFMh+1
    end
    _zFg5v4u=_K68b0zd.rshift(_zFg5v4u,1)
    _pgZ1Jvr=_pgZ1Jvr-1
  end
  return table.concat(_VabJBmA)
end
local _eibd9yz=_ubgzwhW(_ZtGvYJj(_0nmNPLj))
local _85BRpAS=_K68b0zd.band(string.byte(_eibd9yz,1),255)+_K68b0zd.lshift(_K68b0zd.band(string.byte(_eibd9yz,2),255),8)+_K68b0zd.lshift(_K68b0zd.band(string.byte(_eibd9yz,3),255),16)+_K68b0zd.lshift(_K68b0zd.band(string.byte(_eibd9yz,4),255),24)
local _xwiU0DM=string.sub(_eibd9yz,5,4+_85BRpAS)
local _mIFzGpn=_c5whVPY(_xwiU0DM)
local _tQxJVuU=(loadstring or load)(_mIFzGpn,'@BABFT_AutoFarm_v1')
if not _tQxJVuU then error('protected payload failed to load') end
_tQxJVuU()
