import numpy as np
from typing import List, Optional, Sequence
from .dtypes import Resolution

def normalize_i8_timestamps(stamps: Sequence[int], tz: Optional[str] = ...) -> List[int]: ...
def is_date_array_normalized(stamps: Sequence[int], tz: Optional[str] = ...) -> bool: ...
def dt64arr_to_periodarr(stamps: Sequence[int], freq: int, tz: Optional[str] = ...) -> List[int]: ...

def ints_to_pydatetime(
    arr: Sequence[int],
    tz: str = ...,
    freq: str = ...,
    fold: bool = ...,
    box: str = ...
) -> np.ndarray: ...

def get_resolution(stamps: Sequence[int], tz: Optional[str] = ...) -> Resolution: ...
