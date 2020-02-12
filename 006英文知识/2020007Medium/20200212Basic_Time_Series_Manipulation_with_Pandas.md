# Basic Time Series Manipulation with Pandas

Laura Fedoruk

Jun 18, 2018 · 7 min read

[Basic Time Series Manipulation with Pandas - Towards Data Science](https://towardsdatascience.com/basic-time-series-manipulation-with-pandas-4432afee64ea)

As someone who works with time series data on almost a daily basis, I have found the pandas Python package to be extremely useful for time series manipulation and analysis.

This basic introduction to time series data manipulation with pandas should allow you to get started in your time series analysis. Specific objectives are to show you how to:

create a date range

work with timestamp data

convert string data to a timestamp

index and slice your time series data in a data frame

resample your time series for different time period aggregates/summary statistics

compute a rolling statistic such as a rolling average

work with missing data

understand the basics of unix/epoch time

understand common pitfalls of time series data analysis

Let’s get started. If you want to play with real data that you have, you may want to start by using pandas read_csv to read in your file to a data frame, however we’re going to start by playing with generated data.

First import the libraries we’ll be working with and then use them to create a date range

import pandas as pd

from datetime import datetime

import numpy as np

date_rng = pd.date_range(start='1/1/2018', end='1/08/2018', freq='H')

This date range has timestamps with an hourly frequency. If we call date_rng we’ll see that it looks like the following:

DatetimeIndex(['2018-01-01 00:00:00', '2018-01-01 01:00:00',

               '2018-01-01 02:00:00', '2018-01-01 03:00:00',

               '2018-01-01 04:00:00', '2018-01-01 05:00:00',

               '2018-01-01 06:00:00', '2018-01-01 07:00:00',

               '2018-01-01 08:00:00', '2018-01-01 09:00:00',

               ...

               '2018-01-07 15:00:00', '2018-01-07 16:00:00',

               '2018-01-07 17:00:00', '2018-01-07 18:00:00',

               '2018-01-07 19:00:00', '2018-01-07 20:00:00',

               '2018-01-07 21:00:00', '2018-01-07 22:00:00',

               '2018-01-07 23:00:00', '2018-01-08 00:00:00'],

              dtype='datetime64[ns]', length=169, freq='H')

We can check the type of the first element:

type(date_rng[0])

#returns

pandas._libs.tslib.Timestamp

Let’s create an example data frame with the timestamp data and look at the first 15 elements:

df = pd.DataFrame(date_rng, columns=['date'])

df['data'] = np.random.randint(0,100,size=(len(date_rng)))

df.head(15)

Example data frame — df

If we want to do time series manipulation, we’ll need to have a date time index so that our data frame is indexed on the timestamp.

Convert the data frame index to a datetime index then show the first elements:

df['datetime'] = pd.to_datetime(df['date'])

df = df.set_index('datetime')

df.drop(['date'], axis=1, inplace=True)

df.head()

df with datetime index

What if our ‘time’ stamps in our data are actually string type vs. numerical? Let’s convert our date_rng to a list of strings and then convert the strings to timestamps.

string_date_rng = [str(x) for x in date_rng]

string_date_rng

#returns

['2018-01-01 00:00:00',

 '2018-01-01 01:00:00',

 '2018-01-01 02:00:00',

 '2018-01-01 03:00:00',

 '2018-01-01 04:00:00',

 '2018-01-01 05:00:00',

 '2018-01-01 06:00:00',

 '2018-01-01 07:00:00',

 '2018-01-01 08:00:00',

 '2018-01-01 09:00:00',...

We can convert the strings to timestamps by inferring their format, then look at the values:

timestamp_date_rng = pd.to_datetime(string_date_rng, infer_datetime_format=True)

timestamp_date_rng

#returns

DatetimeIndex(['2018-01-01 00:00:00', '2018-01-01 01:00:00',

               '2018-01-01 02:00:00', '2018-01-01 03:00:00',

               '2018-01-01 04:00:00', '2018-01-01 05:00:00',

               '2018-01-01 06:00:00', '2018-01-01 07:00:00',

               '2018-01-01 08:00:00', '2018-01-01 09:00:00',

               ...

               '2018-01-07 15:00:00', '2018-01-07 16:00:00',

               '2018-01-07 17:00:00', '2018-01-07 18:00:00',

               '2018-01-07 19:00:00', '2018-01-07 20:00:00',

               '2018-01-07 21:00:00', '2018-01-07 22:00:00',

               '2018-01-07 23:00:00', '2018-01-08 00:00:00'],

              dtype='datetime64[ns]', length=169, freq=None)

But what about if we need to convert a unique string format?

Let’s create an arbitrary list of dates that are strings and convert them to timestamps:

string_date_rng_2 = ['June-01-2018', 'June-02-2018', 'June-03-2018']

timestamp_date_rng_2 = [datetime.strptime(x,'%B-%d-%Y') for x in string_date_rng_2]

timestamp_date_rng_2

#returns

[datetime.datetime(2018, 6, 1, 0, 0),

 datetime.datetime(2018, 6, 2, 0, 0),

 datetime.datetime(2018, 6, 3, 0, 0)]

What does it look like if we put this into a data frame?

df2 = pd.DataFrame(timestamp_date_rng_2, columns=['date'])

df2

Going back to our original data frame, let’s look at the data by parsing on timestamp index:

Say we just want to see data where the date is the 2nd of the month, we could use the index as per below.

df[df.index.day == 2]

The top of this looks like:

We could also directly call a date that we want to look at via the index of the data frame:

df['2018-01-03']

What about selecting data between certain dates?

df['2018-01-04':'2018-01-06']

The basic data frame that we’ve populated gives us data on an hourly frequency, but we can resample the data at a different frequency and specify how we would like to compute the summary statistic for the new sample frequency. We could take the min, max, average, sum, etc., of the data at a daily frequency instead of an hourly frequency as per the example below where we compute the daily average of the data:

df.resample('D').mean()

What about window statistics such as a rolling mean or a rolling sum?

Let’s create a new column in our original df that computes the rolling sum over a 3 window period and then look at the top of the data frame:

df['rolling_sum'] = df.rolling(3).sum()

df.head(10)

We can see that this is computing correctly and that it only starts having valid values when there are three periods over which to look back.

This is a good chance to see how we can do forward or backfilling of data when working with missing data values.

Here’s our df but with a new column that takes the rolling sum and backfills the data:

df['rolling_sum_backfilled'] = df['rolling_sum'].fillna(method='backfill')

df.head(10)

It’s often useful to be able to fill your missing data with realistic values such as the average of a time period, but always remember that if you are working with a time series problem and want your data to be realistic, you should not do a backfill of your data as that’s like looking into the future and getting information you would never have at that time period. Likely you will want to forward fill your data more frequently than you backfill.

When working with time series data, you may come across time values that are in Unix time. Unix time, also called Epoch time is the number of seconds that have elapsed since 00:00:00 Coordinated Universal Time (UTC), Thursday, 1 January 1970. Using Unix time helps to disambiguate time stamps so that we don’t get confused by time zones, daylight savings time, etc.

Here’s an example of a time t that is in Epoch time and converting unix/epoch time to a regular time stamp in UTC:

epoch_t = 1529272655

real_t = pd.to_datetime(epoch_t, unit='s')

real_t

#returns

Timestamp('2018-06-17 21:57:35')

If I wanted to convert that time that is in UTC to my own time zone, I could simply do the following:

real_t.tz_localize('UTC').tz_convert('US/Pacific')

#returns

Timestamp('2018-06-17 14:57:35-0700', tz='US/Pacific')

With these basics, you should be all set to work with your time series data.

Here are a few tips to keep in mind and common pitfalls to avoid when working with time series data:

Check for discrepancies in your data that may be caused by region specific time changes like daylight savings time.

Keep track of time zones meticulously — let others going through your code know what time zone your data is in, and think about converting to UTC or a standardized value in order to keep your data standardized.

Missing data can occur frequently — make sure you document your cleaning rules and think about not backfilling information you wouldn’t have been able to have at the time of a sample.

Remember that as you resample your data or fill in missing values, you’re losing a certain amount of information about your original data set. I’d suggest keeping track of all of your data transformations and tracking the root cause of your data issues.

When you resample your data, the best method (mean, min, max, sum, etc.) will be dependent on the kind of data you have and how it was sampled. Be thoughtful about how you resample your data for your analysis.

